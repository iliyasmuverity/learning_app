
import 'package:flutter/material.dart';
import '../constants/size_config.dart';
import 'Student/Ui/page_1.dart';

class SignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff293847),
      appBar: AppBar(
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
      body: Container(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.25),
                Text(
                  'You want to register yourself as',
                  style: TextStyle(
                      color: Color(0xffFF5C01).withOpacity(0.85),
                      fontWeight: FontWeight.bold,
                      fontSize: SizeConfig.textMultiplier * 3),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.1),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentRegistrationForm()),
                    );
                  },
                  child: Container(
                      width: SizeConfig.screenWidth * 0.7,
                      height: SizeConfig.screenWidth * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Student',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                InkWell(
                  onTap: () {
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                          builder: (context) => EmployerRegistrationForm()),
//                    );
                  },
                  child: Container(
                      width: SizeConfig.screenWidth * 0.7,
                      height: SizeConfig.screenWidth * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Employer',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                InkWell(
                  onTap: () {
//    Navigator.push(
//    context,
//    MaterialPageRoute(builder: (context) => DropDown()),
//    );
                  },
                  child: Container(
                      width: SizeConfig.screenWidth * 0.7,
                      height: SizeConfig.screenWidth * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Agency',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
                SizedBox(height: SizeConfig.screenHeight * 0.02),
                InkWell(
                  onTap: () {},
                  child: Container(
                      width: SizeConfig.screenWidth * 0.7,
                      height: SizeConfig.screenWidth * 0.12,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          'Regulators',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
              ],
            ),
          )),
    );
  }
}



