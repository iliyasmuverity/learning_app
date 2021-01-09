import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_app/Employer_module/Notifiers/page1_notifier.dart';
import 'package:learning_app/Employer_module/Notifiers/page2_notifier.dart';
import 'package:learning_app/Employer_module/Ui/page_3.dart';
import 'package:learning_app/Helper_UI/widgetchooser.dart';
import 'package:learning_app/constants/size_config.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class EmployerHomePage2 extends StatelessWidget {
  final i;
  final Name;
  final Id;
  final profile_pic;
  final description, pdfResume;
  final certificateList,email;

  const EmployerHomePage2(
      {Key key,
      this.i,
      this.Name,
      this.Id,
      this.profile_pic,
      this.description,
      this.certificateList,
      this.pdfResume, this.email})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> listC;
    if (certificateList != null) {
      listC =
          certificateList.replaceFirst("[", '').replaceAll("]", '').split(',');
      print(listC[2]);
    }

    return ChangeNotifierProvider<Page1Provider>(
        create: (context) => Page1Provider(),
        child: Builder(builder: (context) {
          return Scaffold(
              backgroundColor: Color(0xffF5EBE8),
              appBar: AppBar(
                elevation: 20,
                shadowColor: Colors.black,
                backgroundColor: Color(0xff293847),
                title: Text("Student's Details info"),
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
              body:
                  Consumer<Page1Provider>(builder: (context, provider, child) {
                print(certificateList);
                _launchURL() async {
                  var url = pdfResume;
                  print(url);
                  if (url != null && await canLaunch(url)) {
                    await launch(url);
                  } else {
                  //  throw 'Could not launch $url';
                    Fluttertoast.showToast(
                      msg: "Résumé Unavailable",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.white,
                      textColor: Colors.redAccent,
                      fontSize: 18.0,
                    );
                  }
                }
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(SizeConfig.heightMultiplier * 4),
                    alignment: Alignment.center,
                    height: SizeConfig.screenHeight ,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(4),
                          width: SizeConfig.screenWidth * 0.8,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              //color: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(
                                  SizeConfig.widthMultiplier)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                Name,
                                style: TextStyle(
                                    color: Color(0xff293847),
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.textMultiplier * 2),
                              ),
                              Text(
                                email,
                                style: TextStyle(
                                    color: Color(0xff293847),
                                    fontWeight: FontWeight.bold,
                                    fontSize: SizeConfig.textMultiplier * 2),
                              ),

                            ],
                          )
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(vertical: 4),
                          width: SizeConfig.widthMultiplier * 30,
                          height: SizeConfig.widthMultiplier * 30,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Color(0xff293847)),
                          child: profile_pic == 'null'
                              ? Text(
                            Name[0],
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF5EBE8)),
                          )
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(
                                SizeConfig.widthMultiplier * 30),
                            child: CachedNetworkImage(
                              width: SizeConfig.widthMultiplier * 28,
                              height: SizeConfig.widthMultiplier * 28,
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              imageUrl: profile_pic,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ),
                          ),
                        ),

                        Text(
                          'List of certificate',
                          style: TextStyle(fontSize: 18),
                        ),
                        certificateList != null
                            ? Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var i in listC)
                                Text(i
                                    .replaceFirst("[", '')
                                    .replaceAll("]", ''))
                            ],
                          ),
                        )
                            : Container(
                          margin: EdgeInsets.all(8),
                          padding: EdgeInsets.all(4),
                          child: Text(
                            'No certificates',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: SizeConfig.textMultiplier * 2),
                          ),
                        ),

                        Text(
                          'Description',
                          style: TextStyle(fontSize: 18),
                        ),

                        description != null ? Text(description):Text('No description available'),
                        RaisedButton(
                          child: Text("Open Resume"),
                          onPressed:(){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => EmployerHomePage3(cvUrl: pdfResume,)),
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              }));
        }));
  }
}
