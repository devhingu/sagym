import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gym/provider/bottom_provider.dart';
import 'package:gym/provider/location_provider.dart';
import 'package:gym/provider/member_provider.dart';
import 'package:gym/provider/user_detail_provider.dart';
import 'package:gym/ui/account/screen/user_profile_screen.dart';
import 'package:gym/ui/auth/screen/changepassword/change_password.dart';
import 'package:gym/ui/auth/screen/forgotpassword/forgot_password.dart';
import 'package:gym/ui/auth/screen/login/sign_in_screen.dart';
import 'package:gym/ui/auth/screen/signup/sign_up_screen.dart';
import 'package:gym/ui/dashboard/screen/addexpenses/add_expenses.dart';
import 'package:gym/ui/dashboard/screen/addexpenses/gym_expenses_list.dart';
import 'package:gym/ui/dashboard/screen/addmember/add_member_screen.dart';
import 'package:gym/ui/dashboard/screen/home_page.dart';
import 'package:gym/ui/dashboard/screen/home_screen.dart';
import 'package:gym/ui/location/screen/location_screen.dart';
import 'package:gym/ui/member/screen/member_list.dart';
import 'package:gym/ui/member/screen/reminder_screen.dart';
import 'package:gym/ui/splash/screen/splash_screen.dart';
import 'package:gym/ui/welcome/screen/welcome_screen.dart';
import 'package:provider/provider.dart';

import 'constants/color_constants.dart';
import 'constants/string_constants.dart';

void main() async {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MemberData(),
        ),
        ChangeNotifierProvider(
          create: (context) => BottomNavigationData(),
        ),
        ChangeNotifierProvider(
          create: (context) => InfoWindowModelData(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserData(),
        ),
      ],
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
        routes: _routes(),
      ),
    );
  }

  Map<String, WidgetBuilder> _routes() => {
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
        ReminderScreen.id: (context) => const ReminderScreen(),
        MemberListScreen.id: (context) => const MemberListScreen(),
        LocationScreen.id: (context) => const LocationScreen(),
      };
}
