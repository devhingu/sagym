// import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/constants/color_constants.dart';
import 'package:gym/ui/auth/screens/forgotpassword/forgot_password.dart';
import 'package:gym/ui/auth/screens/login/sign_in_screen.dart';
import 'package:gym/ui/auth/screens/signup/sign_up_screen.dart';
import 'package:gym/ui/dashboard/screens/addexpenses/add_expenses.dart';
import 'package:gym/ui/dashboard/screens/addmember/add_member_screen.dart';
import 'package:gym/ui/dashboard/screens/home_page.dart';
import 'package:gym/ui/dashboard/screens/home_screen.dart';
// import 'package:gym/ui/welcome/screens/welcome_screen.dart';

void main() async{
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
  //     overlays: [SystemUiOverlay.bottom]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gym Management App',
      theme: ThemeData(
        fontFamily: "Poppins",
        primaryColor: kMainColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: kMainColor,
        ),
        scaffoldBackgroundColor: kBackgroundColor,
      ),
      //home: SplashScreen(),
      initialRoute: SignInScreen.id,
      routes: {
        SignInScreen.id: (context) => const SignInScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        ForgotPasswordScreen.id: (context) => const ForgotPasswordScreen(),
        HomePage.id: (context) => const HomePage(),
        HomeScreen.id: (context) => const HomeScreen(),
        AddMemberScreen.id: (context) => const AddMemberScreen(),
        AddExpensesScreen.id: (context) => const AddExpensesScreen(),
        // AddMemberPaymentScreen.id: (context) => const AddMemberPaymentScreen(e),

        //WelcomeScreen.id: (context) => const WelcomeScreen(),
      },
    );
  }
}
