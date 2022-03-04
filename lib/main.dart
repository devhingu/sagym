import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/provider/member_provider.dart';
import 'package:gym/ui/account/screens/user_profile_screen.dart';
import 'package:gym/ui/auth/constants/auth_constants.dart';
import 'package:gym/ui/auth/screens/changepassword/change_password.dart';
import 'package:gym/ui/auth/screens/forgotpassword/forgot_password.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/auth/screens/signup/sign_up_screen.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/add_expenses.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/gym_expenses_list.dart';
import 'package:gym/ui/dashboard/screens/addmember/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';
import 'package:gym/ui/splash/screens/splash_screen.dart';
import 'package:gym/ui/welcome/screens/welcome_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 /* SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);*/
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MemberData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kTitleSaGym,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: "Poppins",
          primaryColor: kMainColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: kMainColor,
          ),
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        initialRoute: SplashScreen.id,
        routes: {
          SignInScreen.id: (context) => const SignInScreen(),
          SignUpScreen.id: (context) => const SignUpScreen(),
          ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
          HomePage.id: (context) => const HomePage(),
          HomeScreen.id: (context) => const HomeScreen(),
          AddMemberScreen.id: (context) => const AddMemberScreen(),
          AddExpensesScreen.id: (context) => const AddExpensesScreen(),
          WelcomeScreen.id: (context) => const WelcomeScreen(),
          SplashScreen.id: (context) => const SplashScreen(),
          UserProfileScreen.id: (context) => const UserProfileScreen(),
          ChangePasswordScreen.id: (context) => const ChangePasswordScreen(),
          GymExpensesList.id: (context) => const GymExpensesList(),
        },
      ),
    );
  }
}
