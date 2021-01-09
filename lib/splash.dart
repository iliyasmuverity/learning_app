import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:learning_app/LogIn_Modue/Ui/logIn_Page.dart';
import 'package:provider/provider.dart';

import 'Sign_Up_module/sign_up_Screen.dart';
import 'constants/constants.dart';
import 'constants/preference.dart';
import 'constants/size_config.dart';


class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isVisible=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  getToken() async{
    try{
      String url = 'https://login.salesforce.com/services/oauth2/token';
      Uri uri = Uri.parse(url);

      var request = new http.MultipartRequest("POST", uri)
        ..fields['username'] = 'iliyas@muverity.com'
        ..fields['password'] = 'qwerty123ZHuEk8uNm1fUbsOlNwgwCXb6'
        ..fields['grant_type'] = 'password'
        ..fields['client_id'] = '3MVG9VeAQy5y3BQVynlWP7liTtzl7VUoGvTqMamb6NfUtzxoKsVThjrRS4rOLDciR3R4TsanBMpbBIu0xwB9b'
        ..fields['client_secret'] = '1D62DDC9334832939762573522B1254C3B714901553C9E8E4D9312E51C81F3AB';

      print("request access token -: $request");
      final response = await request.send();
      final respStr = await response.stream.bytesToString();

      print("response ===> $respStr");
      await PreferenceUtils.setString(Constants.TOKEN, json.decode(respStr)['access_token']);
      await PreferenceUtils.setString(Constants.OWNER_ID, json.decode(respStr)['id'].toString().split('/').last);
      String aToken = PreferenceUtils.getString(Constants.TOKEN);
      print('Acess Owner ID ======> ${PreferenceUtils.getString(Constants.OWNER_ID)}');
      print('Acess Token ======> $aToken');
      setState(() {
        isVisible = true;
      });


      return respStr;



    } catch (e) {
      print(e);
      return e.toString();
    }


  }
  @override
  void initState() {
    getToken();
    super.initState();
  }
  DateTime currentBackPressTime;
  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      //Fluttertoast.showToast(msg: 'Press Again To Exit');
      _scaffoldKey.currentState.showSnackBar(new SnackBar(content: new Text('Press Again To Exit')));


      return Future.value(false);
    }else{
      SystemNavigator.pop();
    }
    return Future.value(true);
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Color(0xff293847),
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: onWillPop,


          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.20),
                  Image.asset('assets/aci_Logo.png'),
                  Text(
                    'LEARNING',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: SizeConfig.textMultiplier * 4),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.15,
                  ),
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {

                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LogIn()),
                            );

                          },
                          child: Container(
                              width: SizeConfig.screenWidth * 0.7,
                              height: SizeConfig.screenWidth * 0.12,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF5C01).withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SignUp()),
                            );
                          },
                          child: Container(
                              width: SizeConfig.screenWidth * 0.7,
                              height: SizeConfig.screenWidth * 0.12,
                              decoration: BoxDecoration(
                                  color: Color(0xffFF5C01).withOpacity(0.85),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Center(
                                child: Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              )),
                        ),
                        SizedBox(
                          height: SizeConfig.screenHeight * 0.03,
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.1,
                  ),

               Text(
                 'We Train Leaders In Cybersecurity, ',
                 style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'RobotoCondensed'),
               ),
               SizedBox(
                 height: SizeConfig.screenHeight * 0.01,
               ),
               Text(
                 'Audit, and Information Technology. ',
                 style: TextStyle(color: Colors.white, fontSize: 18,fontFamily: 'RobotoCondensed'),
               ),



                ],
              ),
            ),
          ),
        )
    );
  }
}




