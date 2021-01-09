import 'package:learning_app/LogIn_Modue/Notifiers/logInNotifier.dart';
import 'package:learning_app/constants/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  final _SignInKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  TextStyle defaultStyle = TextStyle(color: Colors.black, fontSize: 20.0, fontFamily: 'RobotoCondensed');
  TextStyle linkStyle = TextStyle(  color: Colors.blue, fontSize: 20.0, fontFamily: 'RobotoCondensed');
  @override
  Widget build(BuildContext context) {
    print(
        "(==================================UI_UPDATED=======================)");
    return ChangeNotifierProvider<LogInProvider>(
        create: (context) => LogInProvider(),
        child: Builder(builder: (context) {
          return Scaffold(
              appBar: AppBar (
                  elevation: 20,
                  shadowColor: Colors.black,
                  backgroundColor: Color(0xff293847),
                  leading: Container(
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Image.asset(
                              'assets/aci_Logo.png',
                              width: SizeConfig.widthMultiplier * 15,
                            ),
                            Text(
                              'LEARNING',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: SizeConfig.textMultiplier * 1.5),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
              backgroundColor: Color(0xff293847),
              body: Form(
                child: Consumer<LogInProvider>(
                    builder: (context, provider, child){
                      return ModalProgressHUD(
                        inAsyncCall: provider.showProgress,
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.screenWidth * 0.2,
                                left: SizeConfig.screenWidth * 0.1),
                            child: Form(
                              key: _SignInKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Log In',
                                    style: TextStyle(
                                        color: Color(0xffFF5C01).withOpacity(0.85),
                                        fontSize: SizeConfig.textMultiplier * 4,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                                  Text(
                                    'Email*',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.textMultiplier * 2.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      width: SizeConfig.screenWidth * 0.55,
                                      // height: SizeConfig.screenWidth * 0.1,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Center(
                                          child: TextFormField(
                                            controller: emailController,
                                            keyboardType: TextInputType.emailAddress,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter valid email_id';
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration.collapsed(
                                                hintText: 'johndoe@mail.com',
                                                border: InputBorder.none
                                            )
                                                .copyWith(isDense: true),
                                          ))),
                                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                                  Text(
                                    'Password*',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: SizeConfig.textMultiplier * 2.5,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          padding: EdgeInsets.all(8),
                                          width: SizeConfig.screenWidth * 0.55,
                                          //height: SizeConfig.screenWidth * 0.1,
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(4)),
                                          child: TextFormField(
                                            controller: passwordController,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return 'Please enter valid password';
                                              }
                                              return null;
                                            },
                                            obscureText: provider.isObscure,

                                            // textAlign: TextAlign.center,
                                            decoration: InputDecoration.collapsed(
                                                hintText: '* * * * * * *',
                                                //contentPadding: EdgeInsets.zero,
                                                border: InputBorder.none)
                                                .copyWith(isDense: true),
                                          )),
                                      SizedBox(width: SizeConfig.screenHeight * 0.05),
                                      InkWell(
                                        onTap: (){
                                          provider.obscurePassword();
                                        },
                                        child:     Icon(
                                          Icons.remove_red_eye_outlined,
                                          color: Colors.white,
                                          size: 30.0,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                                  Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(4)),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Forgot password? Click here to",
                                              style: defaultStyle),
                                          InkWell(
                                            onTap: () {
                                              print("Reset password ");
                                            },
                                            child: Text("Reset password ", style: linkStyle),
                                          )
                                        ],
                                      )),
                                  SizedBox(height: SizeConfig.screenHeight * 0.05),
                                  InkWell(
                                    onTap: () async{
                                     // provider.dummyLogIn();
                                     await provider.logIn(emailController.text, passwordController.text);

//                                     emailController.clear();
//                                     passwordController.clear();
                                    },
                                    child: Container(
                                        width: SizeConfig.screenWidth * 0.4,
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
                                ],
                              ),
                            ),
                          ),
                        ),
                      );

                    }


                ),
              )
          );
        }
        )
    );
  }
}
