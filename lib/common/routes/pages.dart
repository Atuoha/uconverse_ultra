import 'package:flutter/material.dart';
import 'package:uconverse_ultra/common/middlewares/middlewares.dart';
import 'package:get/get.dart';
import '../../pages/frames/authentication/sign_in/index.dart';
import '../../pages/frames/welcome/index.dart';
import '../../pages/frames/splash/index.dart';
import '../../pages/message/index.dart';
import '../../pages/profile/index.dart';
import '../../pages/contacts/index.dart';
import 'routes.dart';

class AppPages {
  static const initial = AppRoutes.initial;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];
  static final List<GetPage> routes = [
    //entry screen
    GetPage(
      name: AppRoutes.initial,
      page: () => const WelcomePage(),
      binding: WelcomeBinding(),
    ),

    // splash screen
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
      middlewares: [
        RouteWelcomeMiddleware(priority: 1),
      ],
    ),

    GetPage(
      name: AppRoutes.signIn,
      page: () => const SignInPage(),
      binding: SignInBinding(),
    ),
/*
    // GetPage(
    //   name: AppRoutes.application,
    //   page: () => ApplicationPage(),
    //   binding: ApplicationBinding(),
    //   middlewares: [
    //     RouteAuthMiddleware(priority: 1),
    //   ],
    // ),

    GetPage(name: AppRoutes.emailLogin, page: () => EmailLoginPage(), binding: EmailLoginBinding()),
    GetPage(name: AppRoutes.register, page: () => RegisterPage(), binding: RegisterBinding()),
    GetPage(name: AppRoutes.forgot, page: () => ForgotPage(), binding: ForgotBinding()),
    GetPage(name: AppRoutes.phone, page: () => PhonePage(), binding: PhoneBinding()),
    GetPage(name: AppRoutes.sendCode, page: () => SendCodePage(), binding: SendCodeBinding()),

 */



    // message screen
    GetPage(
      name: AppRoutes.message,
      page: () => const MessagePage(),
      binding: MessageBinding(),
      middlewares: [
        RouteAuthMiddleware(priority: 1),
      ],
    ),


    // contact page
    GetPage(
      name: AppRoutes.contact,
      page: () => const ContactsPage(),
      binding: ContactsBinding(),
    ),

    // profile page
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),

    /*
    GetPage(name: AppRoutes.chat, page: () => ChatPage(), binding: ChatBinding()),

    GetPage(name: AppRoutes.photoImgView, page: () => PhotoImgViewPage(), binding: PhotoImgViewBinding()),
    GetPage(name: AppRoutes.voiceCall, page: () => VoiceCallViewPage(), binding: VoiceCallViewBinding()),
    GetPage(name: AppRoutes.videoCall, page: () => VideoCallPage(), binding: VideoCallBinding()),


    */
  ];
}
