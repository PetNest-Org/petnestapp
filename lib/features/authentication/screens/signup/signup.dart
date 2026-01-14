import 'package:demopetnest/common/widgets/appbar/appbar.dart';
import 'package:demopetnest/common/widgets/signup/form_divider.dart';
import 'package:demopetnest/common/widgets/signup/social_buttons.dart';
import 'package:demopetnest/features/authentication/screens/signup/widgets/signupform.dart';
import 'package:demopetnest/utils/constants/sizes.dart';
import 'package:demopetnest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              ///Title
              Text(
                TTexts.signupTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Form
              const TSignupForm(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Divider
              TFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ///Social Buttons
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
