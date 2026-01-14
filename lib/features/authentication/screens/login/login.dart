import 'package:demopetnest/common/styles/spacing_style.dart';
import 'package:demopetnest/common/widgets/signup/form_divider.dart';
import 'package:demopetnest/common/widgets/signup/social_buttons.dart';
import 'package:demopetnest/features/authentication/screens/login/widgets/login_form.dart';
import 'package:demopetnest/features/authentication/screens/login/widgets/login_header.dart';
import 'package:demopetnest/utils/constants/sizes.dart';
import 'package:demopetnest/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              ///Logo , Title & Sub-Title
              const LoginHeader(),

              ///Form
              const LoginForm(),

              ///Divider
              TFormDivider(dividerText: TTexts.orSignInWith.capitalize!),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              ///Footer
              const TSocialButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
