import 'package:flutter/material.dart';

import 'package:learning_app/constants/size_config.dart';
import 'package:learning_app/samples/sample_Notifier.dart';
import 'package:provider/provider.dart';

class ClassNameHere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProviderClass>(
        create: (context) => ProviderClass(),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Color(0xffF5EBE8),
            appBar: AppBar(
              elevation: 20,
              shadowColor: Colors.black,
              backgroundColor: Color(0xff293847),
              title: Text("Your title Here"),
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
            body: Container(),
          );
        }));
  }
}