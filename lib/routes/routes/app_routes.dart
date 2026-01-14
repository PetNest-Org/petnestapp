import 'package:demopetnest/features/authentication/screens/login/login.dart';
import 'package:demopetnest/features/authentication/screens/onboarding/onboarding.dart';
import 'package:demopetnest/features/authentication/screens/password_configuration/forget_password.dart';
import 'package:demopetnest/features/authentication/screens/signup/signup.dart';
import 'package:demopetnest/features/authentication/screens/signup/verify_email.dart';
import 'package:demopetnest/routes/routes/routes.dart';
import 'package:get/get.dart';


class AppRoutes {
  static final pages = [
    //GetPage(name: TRoutes.home, page: () => HomeScreen()),
    //GetPage(name: TRoutes.store, page: () => StoreScreen()),
    // GetPage(name: TRoutes.favourites, page: () => FevouriteScreen()),
    // GetPage(name: TRoutes.setting, page: () => SettingsScreen()),
    // GetPage(name: TRoutes.productReviews, page: () => TProductReviewsScreen()),
    // GetPage(name: TRoutes.order, page: () => OrderScreen()),
    // GetPage(name: TRoutes.checkout, page: () => CheckoutScreen()),
    // GetPage(name: TRoutes.cart, page: () => CartScreen()),
    // GetPage(name: TRoutes.userProfile, page: () => ProfileScreen()),
    // GetPage(name: TRoutes.userAddress, page: () => UserAddressScreen()),
     GetPage(name: TRoutes.signup, page: () => SignupScreen()),
     GetPage(name: TRoutes.verifyEmail, page: () => VerifyEmailScreen()),
     GetPage(name: TRoutes.signIn, page: () => LoginScreen()),
     GetPage(name: TRoutes.forgetPassword, page: () => ForgetPassword()),
    GetPage(name: TRoutes.onBoarding, page: () => OnBoardingScreen()),
  ];
}
