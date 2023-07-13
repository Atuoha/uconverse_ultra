import 'package:get/get.dart';

import '../../common/entities/contact.dart';

class ContactsState {
  var count = 0.obs;
  RxList<ContactItem> contactList = <ContactItem>[].obs;
}
