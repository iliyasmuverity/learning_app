import 'dart:io' as Io;
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning_app/Sign_Up_module/Student/Notifier/page1_notifier.dart';
import 'package:learning_app/Sign_Up_module/Student/Ui/page_2.dart';
import 'package:learning_app/constants/constants.dart';
import 'package:learning_app/constants/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class StudentRegistrationForm extends StatelessWidget {
  final studentSignUpKey = GlobalKey<FormState>();
  final TextEditingController _studentFirstNameController =
      new TextEditingController();
  final TextEditingController _studentLastNameController =
      new TextEditingController();
  final TextEditingController _studentEmailController =
      new TextEditingController();
  final TextEditingController _studentNumberController =
      new TextEditingController();
  final TextEditingController _studentZipController =
      new TextEditingController();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();
  final TextEditingController _genderController = new TextEditingController();
  final TextEditingController _branchController = new TextEditingController();
  final TextEditingController _payGradeController = new TextEditingController();
  final TextEditingController _statusController = new TextEditingController();
  final TextEditingController _resume = new TextEditingController();

  void clearControllers() {
    _studentFirstNameController.clear();
    _studentLastNameController.clear();
    _genderController.clear();
    _branchController.clear();
    _payGradeController.clear();
    _statusController.clear();
    _studentNumberController.clear();
    _studentEmailController.clear();
    _studentZipController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    _resume.clear();
  }

  @override
  Widget build(BuildContext context) {
    print(
        "(==================================UI_UPDATED=======================)");
    return ChangeNotifierProvider<Page1Provider>(
        create: (context) => Page1Provider(),
        child: Builder(builder: (context) {
          final node = FocusScope.of(context);
          return Scaffold(
              backgroundColor: Color(0xffF5EBE8),
              appBar: AppBar(
                elevation: 20,
                shadowColor: Colors.black,
                backgroundColor: Color(0xff293847),
                title: Text('Registration Page 1/3'),
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
                ),
              ),
              body: Form(
                child: Consumer<Page1Provider>(
                    builder: (context, provider, child) {
                  return ModalProgressHUD(
                    inAsyncCall: provider.showProgress,
                    child: SingleChildScrollView(
                      child: Container(
                          child: Form(
                        key: studentSignUpKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: SizeConfig.screenHeight * 0.03),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/longArrow.svg',
                                      color:
                                          Color(0xffFF5C01).withOpacity(0.85),
                                      //width: SizeConfig.screenWidth * 0.25,
                                      height: SizeConfig.screenWidth * 0.1,
                                    ),
                                    Icon(Icons.looks_one,
                                        size: 30,
                                        color:
                                            Colors.green[800].withOpacity(0.7)),
                                  ],
                                ),
                                SvgPicture.asset(
                                  'assets/longArrow.svg',
                                  color: Colors.redAccent.withOpacity(0.3),
                                  width: SizeConfig.screenWidth * 0.15,
                                  height: SizeConfig.screenWidth * 0.06,
                                ),
                                SvgPicture.asset(
                                  'assets/longArrow.svg',
                                  color: Colors.redAccent.withOpacity(0.3),
                                  width: SizeConfig.screenWidth * 0.15,
                                  height: SizeConfig.screenWidth * 0.06,
                                ),
                              ],
                            ),
                            SizedBox(height: SizeConfig.screenHeight * 0.03),
                            Stack(
                              children: [
                                Container(
                                    width: SizeConfig.screenWidth * 0.35,
                                    height: SizeConfig.screenWidth * 0.35,
                                    child: CircleAvatar(
                                      backgroundColor: Color(0xff293847),
                                      child: CircleAvatar(
                                        radius: SizeConfig.screenWidth * 0.17,
                                        backgroundImage: provider.img == null
                                            ? new AssetImage(
                                                'assets/default.png',

                                                // fit: BoxFit.cover,
                                              )
                                            : new MemoryImage(
                                                provider.img,
                                                //fit: BoxFit.cover,
                                              ),
                                      ),
                                    )),
                                Positioned(
                                    left: SizeConfig.screenWidth * 0.24,
                                    top: SizeConfig.screenWidth * 0.24,
                                    child: NeuButton(
                                      decoration: NeumorphicDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffF5EBE8),
                                        border: Border.all(),
                                      ),
                                      onPressed: () {
                                        provider.getImage();
                                      },
                                      child: new Icon(
                                        Icons.add_a_photo,
                                        color: Color(0xff293847),
                                        //size: 10,
                                      ),
                                    ))
                              ],
                            ),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                // height: SizeConfig.screenWidth * 0.2,
                                decoration: BoxDecoration(
                                    // border: Border.all(),
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter first name';
                                          }
                                          return null;
                                        },
                                        controller: _studentFirstNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Fisrt name*',
                                        ).copyWith(isDense: true),
                                        onEditingComplete: () {
                                          // _studentFirstNameController.text.toUpperCase();
                                          node.nextFocus();
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return 'Please enter last name';
                                          }
                                          return null;
                                        },
                                        controller: _studentLastNameController,
                                        decoration: InputDecoration(
                                          labelText: 'Last name*',
                                        ).copyWith(isDense: true),
                                        onEditingComplete: () =>
                                            node.nextFocus(),
                                      ),
                                    )
                                  ],
                                )),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: Text(
                                'Please select the suitable option from dropdown list',
                                style: GoogleFonts.roboto(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                            ),
                            Container(
                              //width: SizeConfig.screenWidth * 0.5,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  new Expanded(
                                      child: new TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select gender';
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    controller: _genderController,
                                    decoration: InputDecoration(
                                        hintText: "Select gender *"),
                                  )),
                                  new PopupMenuButton<String>(
                                    icon: const Icon(Icons.arrow_drop_down,
                                        size: 30, color: Color(0xff293847)),
                                    onSelected: (String value) {
                                      _genderController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return items1.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return new PopupMenuItem(
                                            child: new Text(value),
                                            value: value);
                                      }).toList();
                                    },
                                  ),
                                  new Expanded(
                                      child: new TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select branch';
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    controller: _branchController,
                                    decoration: InputDecoration(
                                        hintText: "Select branch *"),
                                  )),
                                  new PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Color(0xff293847),
                                    ),
                                    onSelected: (String value) {
                                      _branchController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return items2.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return new PopupMenuItem(
                                            child: new Text(value),
                                            value: value);
                                      }).toList();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              //width: SizeConfig.screenWidth * 0.5,
                              padding: EdgeInsets.all(8),
                              child: Row(
                                children: <Widget>[
                                  new Expanded(
                                      child: new TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select paygrade';
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    controller: _payGradeController,
                                    decoration: InputDecoration(
                                        hintText: "Select paygrade *"),
                                  )),
                                  new PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Color(0xff293847),
                                    ),
                                    onSelected: (String value) {
                                      _payGradeController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return items3.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return new PopupMenuItem(
                                            child: new Text(value),
                                            value: value);
                                      }).toList();
                                    },
                                  ),
                                  new Expanded(
                                      child: new TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please select status';
                                      }
                                      return null;
                                    },
                                    readOnly: true,
                                    controller: _statusController,
                                    decoration: InputDecoration(
                                        hintText: "Select status *"),
                                  )),
                                  new PopupMenuButton<String>(
                                    icon: const Icon(
                                      Icons.arrow_drop_down,
                                      size: 30,
                                      color: Color(0xff293847),
                                    ),
                                    onSelected: (String value) {
                                      _statusController.text = value;
                                    },
                                    itemBuilder: (BuildContext context) {
                                      return items4.map<PopupMenuItem<String>>(
                                          (String value) {
                                        return new PopupMenuItem(
                                            child: new Text(value),
                                            value: value);
                                      }).toList();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                //height: SizeConfig.screenWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid phone number';
                                    }
                                    return null;
                                  },
                                  controller: _studentNumberController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                          labelText: 'phone number*')
                                      .copyWith(isDense: true),
                                  onEditingComplete: () => node.nextFocus(),
                                )),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                //height: SizeConfig.screenWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextFormField(
                                  validator: validateEmail,
                                  controller: _studentEmailController,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: 'email*',
                                    //border: InputBorder.none
                                  ).copyWith(isDense: true),
                                  onEditingComplete: () => node.nextFocus(),
                                )),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                //height: SizeConfig.screenWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Please enter valid zipcode';
                                    }
                                    return null;
                                  },
                                  controller: _studentZipController,
                                  maxLength: 10,
                                  keyboardType: TextInputType.phone,
                                  decoration:
                                      InputDecoration(labelText: 'zip code*')
                                          .copyWith(isDense: true),
                                  onEditingComplete: () => node.nextFocus(),
                                )),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                //height: SizeConfig.screenWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextFormField(
                                  validator: validatePassword,
                                  controller: _passwordController,
                                  obscureText: true,
                                  //keyboardType: TextInputType.phone,
                                  decoration:
                                      InputDecoration(labelText: 'password*')
                                          .copyWith(isDense: true),
                                  onEditingComplete: () => node.nextFocus(),
                                )),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                //height: SizeConfig.screenWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextFormField(
                                  validator: (String value) {
                                    return confirmPassword(
                                        value, _passwordController.text);
                                  },

                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  //keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                          labelText: 'confirm password*')
                                      .copyWith(isDense: true),
                                  onEditingComplete: () => node.unfocus(),
                                )),
                            SizedBox(
                              height: SizeConfig.widthMultiplier * 5,
                            ),
                            Container(
                                padding: EdgeInsets.all(8),
                                // width: SizeConfig.screenWidth * 0.55,
                                //height: SizeConfig.screenWidth * 0.1,
                                decoration: BoxDecoration(
                                    color: Color(0xffF5EBE8),
                                    borderRadius: BorderRadius.circular(4)),
                                child: TextFormField(
                                  controller: _resume,
                                  //keyboardType: TextInputType.phone,
                                  decoration:
                                      InputDecoration(labelText: 'Resume *')
                                          .copyWith(isDense: true),
                                  readOnly: true,
                                )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 5),
//                      width: SizeConfig.screenWidth * 0.3,
//                      height: SizeConfig.screenWidth * 0.1,
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffFF5C01).withOpacity(0.85),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: MaterialButton(
                                      onPressed: () async {
                                        await provider.getPdf();
                                        _resume.text = provider.file.path
                                            .toString()
                                            .split('/')
                                            .last;
                                      },
                                      child: Text(
                                        'Upload Resume',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            SizeConfig.widthMultiplier * 5),
//                      width: SizeConfig.screenWidth * 0.3,
//                      height: SizeConfig.screenWidth * 0.1,
                                    decoration: BoxDecoration(
                                        color:
                                            Color(0xffFF5C01).withOpacity(0.85),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: MaterialButton(


                                      onPressed: () async {
                                        //print(provider.img64);
                                        //print(provider.pdf64);
//                                        if(provider.img64.isNotEmpty && provider.pdf64.isNotEmpty){
//                                          print('Okay');
//                                        }else{
//                                          print('Not Okay');
//                                        }
                                        if (studentSignUpKey.currentState.validate())
                                        {
                                          if(provider.img64 != null && provider.img64.isNotEmpty ){
                                            if(provider.pdf64 != null && provider.pdf64.isNotEmpty){
                                              await provider.signUpSalesForce(
                                                name1: _studentFirstNameController
                                                    .text,
                                                name2:
                                                _studentLastNameController.text,
                                                gender: _genderController.text,
                                                branch: _branchController.text,
                                                payGrade: _payGradeController.text,
                                                status: _statusController.text,
                                                phone:
                                                _studentNumberController.text,
                                                email: _studentEmailController.text,
                                                zip: _studentZipController.text,
                                                password: _passwordController.text,
                                                confirm:
                                                _confirmPasswordController.text,
                                              );
                                              clearControllers();
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        StudentRegistrationForm2()),
                                              );
                                            }else {
                                              provider.toastAlert2();


                                            }

                                          }else {
                                            provider.toastAlert1();


                                          }

                                        }else {
                                          provider.toastAlert1();
                                          provider.toastAlert2();
                                        }
                                      },
                                      child: Text(
                                        'Submit',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: SizeConfig.widthMultiplier * 5,
                            ),
                          ],
                        ),
                      )),
                    ),
                  );
                }),
              ));
        }));
  }

  String validateName(String fullName) {
    String pattern = r'/^[a-zA-Z]*$/';
    RegExp regExp = new RegExp(pattern);
    if (fullName.isEmpty) {
      return 'First name is required';
    } else if (fullName.length <= 5) {
      return 'user name must be greater than 5 alphabets';
    }
//    else if (!regExp.hasMatch(fullName)) {
//      return 'Invalid user name';
//    }
    return null;
  }

  String validateLastName(String fullName) {
    String pattern = r'/^[a-zA-Z]*$/';
    RegExp regExp = new RegExp(pattern);
    if (fullName.isEmpty) {
      return 'Last name is required';
    } else if (fullName.length <= 5) {
      return 'user name must be greater than 5 alphabets';
    }
//    else if (!regExp.hasMatch(fullName)) {
//      return 'Invalid user name';
//    }
    return null;
  }

  String validateEmail(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (email.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(email)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }

  String validatePassword(String value) {
    if (value.length == 0) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be more than 6 characters';
    }
    return null;
  }

  String confirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) {
      return 'confirm password is required';
    } else if (password != confirmPassword) {
      return 'passwords does not match';
    } else {
      return null;
    }
  }
}
