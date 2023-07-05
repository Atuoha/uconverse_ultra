import 'package:get/get.dart';
import '../../common/entities/user.dart';

class ProfileState {
  final userDetails = UserItem().obs;

  bool isOnline = true;
}
