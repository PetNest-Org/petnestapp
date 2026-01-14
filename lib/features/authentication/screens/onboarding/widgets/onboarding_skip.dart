import 'package:demopetnest/features/authentication/controller/onboarding/onboarding_controller.dart';
import 'package:demopetnest/utils/constants/sizes.dart';
import 'package:demopetnest/utils/device/device_utility.dart';
import 'package:flutter/material.dart';



class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skinPage(),
        child: const Text('Skip'),
      ),
    );
  }
}
