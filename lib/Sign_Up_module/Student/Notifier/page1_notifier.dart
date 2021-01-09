import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:learning_app/Sign_Up_module/Student/Services/page1_service.dart';
import 'package:learning_app/navigator_key.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_app/LogIn_Modue/Model/logIn_Model.dart';
import 'package:learning_app/LogIn_Modue/Services/authService.dart';
import 'package:learning_app/main.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:io' as Io;

import 'package:crypto/crypto.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class Page1Provider extends ChangeNotifier{
  Page1Provider({this.showProgress = false,this.showPassword = true,this.showConfirmPassword = true});
  bool showProgress,showPassword,showConfirmPassword;
  void obscurePassword(){
    showPassword = !showPassword;
    notifyListeners();
  }

  void obscureConfirmPassword() {
    showConfirmPassword = !showConfirmPassword;
    notifyListeners();
  }

  Io.File image;
  final picker = ImagePicker();
  String img64,pdf64;
  Uint8List img;
  File file;
 // PlatformFile file;

  Future getPdf() async{
//    FilePickerResult result = await FilePicker.platform.pickFiles(
//      type: FileType.custom,
//      allowedExtensions: ['pdf'],);
    file = await FilePicker.getFile(type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    print(file.path);
    print(file);



    if(file != null) {
//     file = result.files.first;
//
//      //resume.text=file.name;
      final bytes22 = Io.File(file.path).readAsBytesSync();
      pdf64 = base64Encode(bytes22);

      print("pdfResume ======================>"+pdf64);

//      print(file.name);
//      print(file.bytes);
//      print(file.size);
//      print(file.extension);
//      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);


    if (pickedFile != null) {
      print("image ======================>" + pickedFile.path);
      image = Io.File(pickedFile.path);

      final bytes = Io.File(image.path).readAsBytesSync();
      img64 = base64Encode(bytes);
      //  print("image ======================>"+img64.length.toString());
      img = base64Decode(img64);
      notifyListeners();
//        print("image ======================>"+img64);
      String _base64;
//        Future<Uint8List> getString() async{
//          final bytes = Io.File('${_image}').readAsBytesSync();
//
//          String img64 = base64Encode(bytes);
//          print(img64);
//        }
//        getString();
      // print("image ======================>"+_image.readAsBytes());
    } else {
      print('No image selected.');
    }

  }
   testing124() {

   }

  Future signUpSalesForce({String name1,
    String name2,
    String gender,
    String branch,
    String payGrade,
    String status,
    String phone,
    String email,
    String zip,
    String password,
    String confirm,
    String resume,
    String image}) async{
    showProgress = true;
    notifyListeners();
    showPassword= true;
    showConfirmPassword = true;
    password = md5.convert(utf8.encode(password)).toString();
    confirm = md5.convert(utf8.encode(confirm)).toString();
   print("MD5_Password is ============>$password");
   print("MD5_Password2 is ============>$confirm");

    await StudentRegistrationService1().signUp(
      name1: name1,
      name2: name2,
      gender: gender,
      branch: branch,
      payGrade:payGrade,
      status: status,
      phone: phone,
      email: email,
      password: password,
      confirm: confirm,
      resume: pdf64,
      zip: zip,
      image: img64
    );

    pdf64 = "";
    notifyListeners();
    img64 = "";
    img = null;
    notifyListeners();
    showProgress = false;
    notifyListeners();
  //  naviGet.navigatorKey.currentState.pushNamed(studentFormPage_2);
  }

void toastAlert1(){
  Fluttertoast.showToast(
msg: " Profile Picture is not selected",
toastLength: Toast.LENGTH_SHORT,
gravity: ToastGravity.CENTER,
timeInSecForIosWeb: 1,
backgroundColor: Colors.red,
textColor: Colors.white,
fontSize: 18.0,

);

}
  void toastAlert2(){
    Fluttertoast.showToast(
      msg: "Resume PDF is not selected",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 18.0,

    );

  }
}