import 'package:flutter/material.dart';
import 'package:learning_app/navigator_key.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Employer_module/Ui/page_1.dart';
import 'Sign_Up_module/Student/Ui/page_2.dart';
import 'Sign_Up_module/Student/Ui/page_3.dart';
import 'splash.dart';
import 'LogIn_Modue/Ui/newpage.dart';


Future main() async{
  SharedPreferences.setMockInitialValues({});
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
const page ='newPage';
const studentFormPage_2 = 'stdPg2';
const studentFormPage_3 = 'stdPg3';
const first = 'splash';
const employerFirst = 'EFP';

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
        navigatorKey: naviGet.navigatorKey,
        initialRoute: '/',
        routes: {
          first:(context) =>   Splash(),
          page:(context) => Page2(),
          studentFormPage_2:(context) => StudentRegistrationForm2(),
          studentFormPage_3:(context) => StudentRegistrationForm3(),
          employerFirst:(context) => EmployerHomePage(),



        },

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash(),
    );
  }
}
