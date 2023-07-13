import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:uconverse_ultra/common/apis/apis.dart';
import 'package:uconverse_ultra/common/entities/contact.dart';
import 'index.dart';

class ContactsController extends GetxController {
  ContactsController();

  final state = ContactsState();
  String name = 'contacts';


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
  void viewChat(ContactItem contactItem) {}

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }




}
