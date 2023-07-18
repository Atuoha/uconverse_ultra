import 'package:get/get.dart';
import '../../common/entities/user.dart';
import '../../common/store/user.dart';

class ProfileState {
  final userDetails = UserStore.to.profile;

  bool isOnline = true;
}
