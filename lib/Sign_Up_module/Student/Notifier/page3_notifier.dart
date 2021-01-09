import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_app/navigator_key.dart';
import 'package:flutter/foundation.dart';
import 'package:learning_app/Sign_Up_module/Student/Services/page3_service.dart';
import 'package:learning_app/main.dart';


class Page3Provider extends ChangeNotifier{
  Page3Provider({this.showProgress = false});
  bool showProgress;

  void addDescription(String description) async{
    showProgress = true;
    notifyListeners();

    if(description != null &&description.isNotEmpty){
      await StudentDescriptionService().submitDescriptipn(description);
    }

    showProgress = false;
    notifyListeners();
    await Fluttertoast.showToast(
      msg: "You have registered Successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,

    );
    await Fluttertoast.showToast(
      msg: "We will send you verification email then you will be able to LogIn",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,

    );

    Future.delayed(const Duration(milliseconds: 5000), () {
      // Here you can write your code
      naviGet.navigatorKey.currentState.pushNamed(first);
    });



  }

}