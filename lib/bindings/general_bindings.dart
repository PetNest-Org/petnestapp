
import 'package:demopetnest/utils/helpers/network_manager.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class GeneralBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkManager());
    // Get.put(VariationController());
    // Get.put(AddressController());
    // Get.put(CheckoutController());
  }
}
