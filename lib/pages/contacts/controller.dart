import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/common/apis/apis.dart';
import 'package:uconverse_ultra/common/entities/contact.dart';
import '../../common/entities/msg.dart';
import '../../common/routes/names.dart';
import '../../common/store/user.dart';
import 'index.dart';

class ContactsController extends GetxController {
  ContactsController();

  final state = ContactsState();
  String name = 'contacts';
  var token = UserStore.to.profile.token;
  var db = FirebaseFirestore.instance;

  // load all contacts
  Future<void> asyncLoadAllData() async {
    EasyLoading.show();
    state.contactList.clear();

    var result = await ContactAPI.post_contact();
    if (result.code == 0) {
      state.contactList.addAll(result.data!);
      print(result.data);
    } else {
      print('Error occurred!');
    }
    EasyLoading.dismiss();
  }

  // viewChat
  void viewChat(ContactItem contactItem) async {
    var fromMessages = await db
        .collection("messages")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, option) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: token)
        .where("to_token", isEqualTo: contactItem.token)
        .get();

    print('....from_messages.....${fromMessages.docs.isEmpty}');

    var toMessages = await db
        .collection("messages")
        .withConverter(
          fromFirestore: Msg.fromFirestore,
          toFirestore: (Msg msg, option) => msg.toFirestore(),
        )
        .where("from_token", isEqualTo: contactItem.token)
        .where("to_token", isEqualTo: token)
        .get();

    print('....to_messages.....${toMessages.docs.isEmpty}');

    if (fromMessages.docs.isEmpty && toMessages.docs.isEmpty) {
      var profile = UserStore.to.profile;
      var msgData = Msg(
        from_token: profile.token,
        from_name: profile.name,
        to_token: contactItem.token,
        to_name: contactItem.name,
        from_avatar: profile.avatar,
        to_avatar: contactItem.avatar,
        from_online: profile.online,
        to_online: contactItem.online,
        last_msg: "",
        last_time: Timestamp.now(),
        msg_num: 0,
      );

      var docId = await db
          .collection("messages")
          .withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg, options) => msg.toFirestore(),
          )
          .add(msgData);

      Get.toNamed(
        AppRoutes.chat,
        parameters: {
          "doc_id": docId.id,
          "to_avatar": contactItem.avatar ?? "",
          "to_name": contactItem.name ?? "",
          "to_online": contactItem.online.toString(),
          "to_token": contactItem.token ?? "",
        },
      );
    } else {
      if (fromMessages.docs.first.id.isNotEmpty) {
        Get.toNamed(
          AppRoutes.chat,
          parameters: {
            "doc_id": fromMessages.docs.first.id,
            "to_avatar": contactItem.avatar ?? "",
            "to_name": contactItem.name ?? "",
            "to_online": contactItem.online.toString(),
            "to_token": contactItem.token ?? "",
          },
        );
      }

      if (toMessages.docs.first.id.isNotEmpty) {
        Get.toNamed(
          AppRoutes.chat,
          parameters: {
            "doc_id": toMessages.docs.first.id,
            "to_avatar": contactItem.avatar ?? "",
            "to_name": contactItem.name ?? "",
            "to_online": contactItem.online.toString(),
            "to_token": contactItem.token ?? "",
          },
        );
      }
    }
  }

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }
}
