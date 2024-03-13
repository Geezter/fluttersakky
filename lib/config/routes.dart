import 'package:kouluharjoittelu/about_page.dart';
import 'package:kouluharjoittelu/box_page.dart';
import 'package:kouluharjoittelu/chat_box.dart';
import 'package:kouluharjoittelu/user_verified_page.dart';
import 'package:kouluharjoittelu/verification_page.dart';
import 'package:kouluharjoittelu/front_page.dart';
import 'package:kouluharjoittelu/profile_page.dart';
import 'package:kouluharjoittelu/registration_page.dart';

class AppRoutes {
  static final pages = {
    main: (context) => const FrontPage(),
    front: (context) => ChatBox(userEmail: verificationEmail),
    box: (context) => const BoxPage(),
    profilePage: (context) => const ProfilePage(),
    registrationPage: (context) => const RegistrationPage(),
    verificationPage: (context) =>
      VerificationPage(verificationEmail: 
      verificationEmail),
    userVerifiedPage: (context) => 
      UserVerifiedPage(email: verificationEmail),
    aboutPage: (context) => const AboutPage(),
  };
 
  static const main = '/';
  static const front = '/chatBox';
  static const box = '/boxPage';
  static const codingTopic = '/codingTopic';
  static const profilePage = '/profilePage';
  static const registrationPage = '/registrationPage';
  static const verificationPage = '/verificationPage';
  static const userVerifiedPage = '/userVerifiedPage';
  static const aboutPage = '/aboutPage';
}
