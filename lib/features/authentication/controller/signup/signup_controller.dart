import 'package:demopetnest/data/repositories/authentication/authentication_repository.dart';
import 'package:demopetnest/data/repositories/user/user_repository.dart';
import 'package:demopetnest/features/authentication/models/user_models.dart';
import 'package:demopetnest/features/authentication/screens/signup/verify_email.dart';
import 'package:demopetnest/utils/constants/image_strings.dart';
import 'package:demopetnest/utils/helpers/network_manager.dart';
import 'package:demopetnest/utils/popups/full_screen_loader.dart';
import 'package:demopetnest/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  ///Veriables
  final email = TextEditingController(); // Controller for Email input
  final firstName = TextEditingController(); // Controller for First Name input
  final lastName = TextEditingController(); // Controller for Last Name input
  final username = TextEditingController(); // Controller for User Name input
  final password = TextEditingController(); // Controller for Password input
  final hidePassword = true.obs; // Controller for Hide Password input
  final privacyPolicy = true.obs;
  final phoneNumber =
      TextEditingController(); // Controller for Phone Number input
  GlobalKey<FormState> signupFormkey = GlobalKey<FormState>();

  /// -- Signup
  Future<void> signup() async {
    try {
      // Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are processing your information', TImages.docerAnimation);

      //Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (isConnected) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Form Validation
      if (!signupFormkey.currentState!.validate()) {
        // Remove Loader
        TFullScreenLoader.stopLoading();
        return;
      }

      //Privacy Policy Check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In Order To Create account , you must have to read and accept the privacy policy & Terms of Use.',
        );
        return;
      }

      //Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //save  Authenticated  user data in the Firebase Firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          username: username.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      // Remove Loader
      TFullScreenLoader.stopLoading();

      //Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratulations!',
          message:
              'Your account has been successfully created !.Verify email to continue');

      //Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      //Remove Loader
      TFullScreenLoader.stopLoading();

      //Show some Generic Error to the user
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
    //  finally {
    // }
  }
}
