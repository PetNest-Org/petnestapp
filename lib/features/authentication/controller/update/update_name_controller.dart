import 'package:demopetnest/data/repositories/user/user_repository.dart';
import 'package:demopetnest/features/personalization/controller/user_controller.dart';
import 'package:demopetnest/utils/constants/image_strings.dart';
import 'package:demopetnest/utils/helpers/network_manager.dart';
import 'package:demopetnest/utils/popups/full_screen_loader.dart';
import 'package:demopetnest/utils/popups/loaders.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';


///  Controller  to manage user-related functionality
class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  ///
  final firstName = TextEditingController();
  final lastname = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  /// Init user data when Home Screen  appears
  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  /// Fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastname.text = userController.user.value.lastName;
  }

  Future<void> updateUserNames() async {
    try {
      /// Start Loading
      TFullScreenLoader.openLoadingDialog(
          'We are updating your information ... ', TImages.docerAnimation);

      /// Check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Form Validation
      if (!updateUserNameFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      /// Update users first & last name in the Firebase Firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastname.text.trim()
      };
      await userRepository.updateSingleField(name);

      /// Update the Rx User Value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastname.text.trim();

      /// Remove Loader
      TFullScreenLoader.stopLoading();

      /// Show Success Message
      TLoaders.successSnackBar(
          title: 'Congratualation', message: 'Your Name has been update');

      /// Move to Previous Screen
     // Get.off(() => ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }
}
