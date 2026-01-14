import 'package:demopetnest/data/repositories/authentication/authentication_repository.dart';
import 'package:demopetnest/features/authentication/screens/password_configuration/reset_password.dart';
import 'package:demopetnest/utils/constants/image_strings.dart';
import 'package:demopetnest/utils/helpers/network_manager.dart';
import 'package:demopetnest/utils/popups/full_screen_loader.dart';
import 'package:demopetnest/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  /// Variables
  final email = TextEditingController();
  GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  /// Send Reset Password Email
  sendPasswordResetEmail() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.docerAnimation);

      /// Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!forgetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Send Email to reset password
      await AuthenticationRepository.instance
          .sendPasswordResetEmail(email.text.trim());

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show success Screen
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link Sent to Reset your Password'.tr);

      /// Redirect
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your request...', TImages.docerAnimation);

      /// Check Internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Send Email to reset password
      await AuthenticationRepository.instance.sendPasswordResetEmail(email);

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show success Screen
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Email link Sent to Reset your Password'.tr);
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
