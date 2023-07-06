import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../common/entities/user.dart';
import '../../../../common/enums/sign_in_type.dart';
import '../../../../common/routes/names.dart';
import '../../../../common/store/user.dart';
import '../../../../common/utils/http.dart';
import '../../../../generated/assets.dart';
import 'state.dart';

class SignInController extends GetxController {
  SignInController();

  final state = SignInState();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['openid'],
  );

  final _firebaseAuth = FirebaseAuth.instance;

  Future<void> handleSignIn(SignInType type) async {
    switch (type) {
      case SignInType.google:
        try {
          // Trigger the authentication flow
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

          // Obtain the auth details from the request
          final GoogleSignInAuthentication? googleAuth =
              await googleUser?.authentication;

          // Create a new credential
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken,
            idToken: googleAuth?.idToken,
          );

          final String? username = googleUser!.displayName;
          final String email = googleUser.email;
          final String photoUrl = googleUser.photoUrl ?? Assets.imagesDefault;
          final LoginRequestEntity loginRequestEntity = LoginRequestEntity();
          loginRequestEntity.email = email;
          loginRequestEntity.avatar = photoUrl;
          loginRequestEntity.name = username;
          loginRequestEntity.open_id = googleUser.id;
          loginRequestEntity.type = type;
          asyncPostAllData();
          _firebaseAuth.signInWithCredential(credential);

          print('Google.........');
        } catch (e) {}
        break;

      case SignInType.facebook:
        try {
          print('Facebook.........');
        } catch (e) {}
        break;

      case SignInType.apple:
        try {
          print('Apple.........');
        } catch (e) {}
        break;

      case SignInType.phone:
        try {
          print('Phone.........');
        } catch (e) {}
        break;

      case SignInType.email:
        try {
          print('Email.........');
        } catch (e) {}
        break;
    }
  }

  void asyncPostAllData() async {
    var response = await HttpUtil().get('/api/index');
    print('DATA GOtten---:: $response');
    UserStore.to.setIsLoggedIn = true;
    Get.offAllNamed(AppRoutes.message);
  }
}
