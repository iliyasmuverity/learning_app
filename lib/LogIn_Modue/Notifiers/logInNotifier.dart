
import 'dart:convert';
import 'package:learning_app/navigator_key.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_app/LogIn_Modue/Model/logIn_Model.dart';
import 'package:learning_app/LogIn_Modue/Services/authService.dart';
import 'package:learning_app/main.dart';

class LogInProvider extends ChangeNotifier{
  LogInProvider({this.showProgress = false,this.isObscure = true});
  bool showProgress;
  bool  isObscure;
  String userDepartment;
  Contact contact;
  void obscurePassword(){
    isObscure = !isObscure;
    notifyListeners();
  }
  void dummyLogIn(){
    naviGet.navigatorKey.currentState.pushReplacementNamed(page);
  }
  Future logIn(String email,String password) async{
    showProgress = true;
    notifyListeners();
    isObscure = true;
    notifyListeners();
    contact = await AuthService().logIn(email, password);
    //print(contact.records[0].department);
    if(contact.totalSize == 1 ){
      password = md5.convert(utf8.encode(password)).toString();
      notifyListeners();
      if(contact.records[0].passwordC != null && contact.records[0].passwordC == password){
        userDepartment = contact.records[0].department;
        print(userDepartment);

        if(userDepartment == 'student'){
          if(contact.records[0].profilePicUrlC != null && contact.records[0].resumeUrlC != null){

            Fluttertoast.showToast(
              msg: "Login Successfully",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green[800],
              textColor: Colors.white,
              fontSize: 18.0,

            );
            notifyListeners();
            naviGet.navigatorKey.currentState.pushReplacementNamed(page);
          }else{
            Fluttertoast.showToast(
              msg: "Your Account is not verified yet",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 18.0,

            );
            notifyListeners();
          }

        }if(userDepartment == 'employer') {
          Fluttertoast.showToast(
            msg: "Login Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.green[800],
            textColor: Colors.white,
            fontSize: 18.0,

          );
          notifyListeners();
          naviGet.navigatorKey.currentState.pushNamed(employerFirst);
        }
        showProgress = false;
        notifyListeners();

      }else{
        showProgress = false;
        notifyListeners();
        Fluttertoast.showToast(
          msg: "There was a problem signing in. Check your email and password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 18.0,
        );
        notifyListeners();
      }

    }else{
      showProgress = false;
      notifyListeners();
      Fluttertoast.showToast(
        msg: "User does not exists",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 18.0,

      );
      notifyListeners();
    }


    showProgress = false;
    notifyListeners();

  }
}