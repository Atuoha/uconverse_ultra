import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../common/store/user.dart';
import 'index.dart';

class ProfileController extends GetxController {
  ProfileController();

  final state = ProfileState();
  final _firebaseAuth = FirebaseAuth.instance;



  // toggle online
  void toggleOnline({required bool value}) {
    state.isOnline = value;
  }

  Future<void> signOut() async {
    // await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await UserStore.to.onLogout();
  }
}
