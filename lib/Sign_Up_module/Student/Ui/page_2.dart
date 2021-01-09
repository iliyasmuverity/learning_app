import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:learning_app/Sign_Up_module/Student/Notifier/page2_notifier.dart';
import 'package:learning_app/Sign_Up_module/Student/Ui/page_3.dart';
import 'package:learning_app/constants/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class StudentRegistrationForm2 extends StatelessWidget {
  final TextEditingController _studentlastNameController =
      new TextEditingController();

  final ScrollController _scrollController = new ScrollController();


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Page2Provider>(
        create: (context) => Page2Provider(),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Color(0xffF5EBE8),
            appBar: AppBar(
              elevation: 20,
              shadowColor: Colors.black,
              backgroundColor: Color(0xff293847),
              title: Text('Registration Page 2/3'),
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
            body: Form(child:
                Consumer<Page2Provider>(builder: (context, provider, child) {
              return ModalProgressHUD(
                inAsyncCall: provider.showProgress,
                child: InkWell(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Container(
                      height: SizeConfig.screenHeight,
                      margin: EdgeInsets.all(16),
                      child: Column(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SvgPicture.asset(
                                'assets/longArrow.svg',
                                color: Colors.redAccent.withOpacity(0.3),
                                width: SizeConfig.screenWidth * 0.15,
                                height: SizeConfig.screenWidth * 0.06,
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/longArrow.svg',
                                    color: Color(0xffFF5C01).withOpacity(0.85),
                                    //width: SizeConfig.screenWidth * 0.25,
                                    height: SizeConfig.screenWidth * 0.1,
                                  ),
                                  Icon(Icons.looks_two,
                                      size: 30,
                                      color: Colors.green[800].withOpacity(0.7)),
                                ],
                              ),
                              SvgPicture.asset(
                                'assets/longArrow.svg',
                                color: Colors.redAccent.withOpacity(0.3),
                                width: SizeConfig.screenWidth * 0.15,
                                height: SizeConfig.screenWidth * 0.06,
                              ),
                            ],
                          ),
                          Text('Please enlist the certificates you have'),
                          SizedBox(
                            width: 20,
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
                                          return 'Please enter certificate name';
                                        }
                                        return null;
                                      },
                                      controller: _studentlastNameController,
                                      decoration: InputDecoration(
                                        labelText:
                                        'Enter the Title of certificate',
                                      ).copyWith(isDense: true),
                                      onEditingComplete: () {
                                        if(_studentlastNameController != null && _studentlastNameController.text.isNotEmpty){
                                          provider
                                              .add(_studentlastNameController.text);
                                          _studentlastNameController.clear();
                                        }

                                      },

                                    ),
                                  ),
                                  NeuButton(
                                    decoration: NeumorphicDecoration(
                                      shape: BoxShape.circle,
                                      color:  Color(0xffF5EBE8),

                                    ),
                                    onPressed: () {
                                      if(_studentlastNameController != null && _studentlastNameController.text.isNotEmpty){
                                        provider
                                            .add(_studentlastNameController.text);
                                        _studentlastNameController.clear();
                                      }

                                    },
                                    child:  Icon(
                                      Icons.add_box,
                                      color: Color(0xff293847),
                                    ),
                                  )
                                ],
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                onPressed: () {
                                  provider.submitCertificateList();
                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                                color: Color(0xffFF5C01).withOpacity(0.85),
                              ),
                              SizedBox(
                                width: SizeConfig.widthMultiplier * 10,
                              ),
                              InkWell(
                                  onTap: () {
                                    if(provider.litems == null || provider.litems.isEmpty){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => StudentRegistrationForm3()),
                                      );
                                    }else{
                                      Fluttertoast.showToast(
                                        msg: "Please Press Submit button",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Color(0xff293847),
                                        textColor: Color(0xffF5EBE8),
                                        fontSize: 18.0,

                                      );
                                    }

                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(8),
                                    child: Text(
                                      'Skip ->>>',
                                      style: TextStyle(
                                          color: Color(0xff293847), fontSize: 18),
                                    ),
                                  )),
                            ],
                          ),
                          Text(
                              'Number of certificates you have:  ${provider.index1}'),
                          Container(
                              height: SizeConfig.screenHeight * 0.2,
//                  decoration: BoxDecoration(
//                    border: Border.all(),
//                  ),
                              child: Scrollbar(
                                isAlwaysShown: provider.index1 ==0?false:true,
                                controller: _scrollController,

                                child: ListView.builder(
                                    itemCount: provider.litems.length,
                                    controller: _scrollController,
                                    reverse: true,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext ctxt, int index) {
                                      return new Container(
                                        margin: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: SizeConfig.screenWidth * 0.6,
//                                decoration: BoxDecoration(
//                                    border: Border.all()
//                                ),
                                              child: Text(provider.litems[index]),
                                            ),

                                            NeuButton(
                                              decoration: NeumorphicDecoration(
                                                  shape: BoxShape.circle,
                                                  color:  Color(0xffF5EBE8)
                                              ),
                                              onPressed: () {
                                                provider
                                                    .removeCertificateFromList(
                                                    index);
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Color(0xff293847),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            })),
          );
        }));
  }
}
