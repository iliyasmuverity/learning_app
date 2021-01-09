import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:learning_app/Sign_Up_module/Student/Notifier/page3_notifier.dart';
import 'package:learning_app/constants/size_config.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class StudentRegistrationForm3 extends StatelessWidget {
  final TextEditingController _descriptionController =
      new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Page3Provider>(
        create: (context) => Page3Provider(),
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
              body: Form(
                child: Consumer<Page3Provider>(
                  builder: (context, provider, child) {
                    return ModalProgressHUD(
                        inAsyncCall: false,
                        child: InkWell(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          child: SingleChildScrollView(
                              child: Container(
                            margin: EdgeInsets.all(16),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
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
                                    Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/longArrow.svg',
                                          color: Color(0xffFF5C01)
                                              .withOpacity(0.85),
                                          //width: SizeConfig.screenWidth * 0.25,
                                          height: SizeConfig.screenWidth * 0.1,
                                        ),
                                        Icon(Icons.looks_3,
                                            size: 30,
                                            color: Colors.green[800]
                                                .withOpacity(0.7)),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Give short description about \n your skills and abilities',
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textMultiplier * 3),
                                    ),
                                  ],
                                ),
                                Container(
                                    height: SizeConfig.screenWidth,
                                    width: SizeConfig.screenWidth,
                                    padding: EdgeInsets.all(8),

                                    margin: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    color: Color(0xffF5EBE8),
                                    child: TextFormField(
                                      controller: _descriptionController,
                                      textInputAction: TextInputAction.newline,
                                      keyboardType: TextInputType.multiline,
                                      textAlign: TextAlign.start,
                                      maxLength: 500,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.grey[900]),
                                      decoration: InputDecoration(
                                        //border: InputBorder.none,
                                        hintText: 'Tell us about your self',
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff293847),
                                              width: 3),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide: BorderSide(
                                              color: Color(0xff293847),
                                              width: 3),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return 'Please enter description';
                                        }
                                        return null;
                                      },
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
                                      onPressed: () {
                                        provider.addDescription(_descriptionController.text);


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
                          )),
                        ));
                  },
                ),
              ));
        }));
  }
}
