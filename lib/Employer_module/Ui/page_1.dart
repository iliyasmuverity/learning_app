import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_app/Employer_module/Notifiers/page1_notifier.dart';
import 'package:learning_app/Employer_module/Ui/page_2.dart';
import 'package:learning_app/Helper_UI/Loading_shimmer.dart';
import 'package:learning_app/Helper_UI/widgetchooser.dart';
import 'package:learning_app/constants/size_config.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EmployerHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Page1Provider>(
        create: (context) => Page1Provider(),
        child: Builder(builder: (context) {
          return Scaffold(
            backgroundColor: Color(0xffF5EBE8),
            appBar: AppBar(
              elevation: 20,
              shadowColor: Colors.black,
              backgroundColor: Color(0xff293847),
              title: Text("Student's Detail List"),
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
            body: Consumer<Page1Provider>(builder: (context, provider, child) {
              RefreshController _refreshController = RefreshController();
              //provider.fetchStudentsDetail();
              return Container(
                height: SizeConfig.screenHeight,
                child: provider.record == null
                    ? Center(
                        child: RaisedButton(
                        onPressed: () async {
                          Fluttertoast.showToast(
                            msg: "Please wait for a moment",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 18.0,
                          );
                          await provider.fetchStudentsDetail();
                        },
                        padding:
                            EdgeInsets.all(SizeConfig.heightMultiplier * 4),
                        child: Text(
                          ' Press Here',
                          style: TextStyle(fontSize: 30),
                        ),
                      ))
                    : SmartRefresher(
                        enablePullDown: false,
                        enablePullUp: true,

                        controller: _refreshController,

                        onLoading: () async {
                          HapticFeedback.heavyImpact();
                          print("Loading start");
                          await provider.fetchStudentsDetail();
                          _refreshController.loadComplete();
                          print("Loading done");
                        },

                        // color: Color(0xff293847),
                        child: ListView.builder(
                          //  physics: BouncingScrollPhysics(parent: ScrollPhysics()),
                          // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1,childAspectRatio: 2),
                          itemCount: provider.record.length,
                          itemBuilder: (context, index) {
                            // ignore: unnecessary_statements
                            provider.cert =
                                provider.record[index].listOfCertificatesC;

                            if (provider.cert != null) {
                              provider.lst = provider.cert.split(",");
                            } else {
                              provider.lst = [];
                            }

                            if (index == provider.record.length) {
                              return ShimmerList();
                            } else {
                              if (provider.record[index].department ==
                                  'student') {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              EmployerHomePage2(
                                                Name:
                                                    provider.record[index].name,
                                                profile_pic: provider
                                                    .record[index]
                                                    .profilePicUrlC
                                                    .toString(),
                                                certificateList: provider
                                                    .record[index]
                                                    .listOfCertificatesC,
                                                pdfResume: provider
                                                    .record[index].resumeUrlC,
                                                description: provider
                                                    .record[index].description,
                                                email: provider.record[index].email,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(10, 10),
                                              color: Colors.black38,
                                              blurRadius: 20),
                                          BoxShadow(
                                              offset: Offset(-10, -10),
                                              color: Colors.white
                                                  .withOpacity(0.85),
                                              blurRadius: 20)
                                        ]),
                                    margin: EdgeInsets.all(8),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 4),
                                          width:
                                              SizeConfig.widthMultiplier * 20,
                                          height:
                                              SizeConfig.widthMultiplier * 20,
                                          decoration: BoxDecoration(
                                              // border: Border.all(),
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig
                                                              .widthMultiplier *
                                                          10)),
                                          child: WidgetChooser(
                                            condition: provider.record[index]
                                                        .profilePicUrlC !=
                                                    null
                                                ? true
                                                : false,
                                            trueChild: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      SizeConfig
                                                              .widthMultiplier *
                                                          10),
                                              child: CachedNetworkImage(
                                                width:
                                                    SizeConfig.widthMultiplier *
                                                        20,
                                                height:
                                                    SizeConfig.widthMultiplier *
                                                        20,
                                                alignment: Alignment.center,
                                                fit: BoxFit.cover,
                                                imageUrl: provider.record[index]
                                                    .profilePicUrlC
                                                    .toString(),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                            falseChild: Text(
                                              provider.record[index].name
                                                  .toString()[0],
                                              style: TextStyle(
                                                  color: Color(0xff293847),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: SizeConfig
                                                          .textMultiplier *
                                                      3),
                                            ),
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
//                                            Container(
//                                              margin: EdgeInsets.all(8),
//                                              padding: EdgeInsets.all(4),
//                                              width:
//                                                  SizeConfig.screenWidth * 0.6,
//                                              decoration: BoxDecoration(
//                                                  border: Border.all(),
//                                                  //color: Colors.grey.withOpacity(0.3),
//                                                  borderRadius: BorderRadius
//                                                      .circular(SizeConfig
//                                                          .widthMultiplier)),
//                                              child: Text(
//                                                provider.record[index].id,
//                                                style: TextStyle(
//                                                    color: Color(0xff293847),
//                                                    fontWeight: FontWeight.bold,
//                                                    fontSize: SizeConfig
//                                                            .textMultiplier *
//                                                        2),
//                                              ),
//                                            ),
                                            Container(
                                                margin: EdgeInsets.all(8),
                                                padding: EdgeInsets.all(4),
                                               // alignment: Alignment.center,
                                                width: SizeConfig.screenWidth *
                                                    0.6,
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    //color: Colors.grey.withOpacity(0.3),
                                                    borderRadius: BorderRadius
                                                        .circular(SizeConfig
                                                            .widthMultiplier)),
                                                child:
                                                    Text(
                                                      provider
                                                          .record[index].name,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xff293847),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2),
                                                    ),


                                            ),

                                            provider.record[index]
                                                        .listOfCertificatesC !=
                                                    null
                                                ? Container(
                                                    margin: EdgeInsets.all(4),
                                                    padding: EdgeInsets.all(4),
                                                    //alignment: Alignment.center,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        for (var i
                                                            in provider.lst)
                                                          Text(i
                                                              .replaceFirst(
                                                                  "[", '')
                                                              .replaceAll(
                                                                  "]", ''))
                                                      ],
                                                    ),
                                                  )
                                                : Container(
                                                    margin: EdgeInsets.all(8),
                                                    padding: EdgeInsets.all(4),
                                                    child: Text(
                                                      'No certificates',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontSize: SizeConfig
                                                                  .textMultiplier *
                                                              2),
                                                    ),
                                                  ),
                                          ],
                                        ),

                                        //data[index]['List_of_Certificates__c'] != null?Text(data[index]['List_of_Certificates__c']):Text(''),
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }
                          },
                        ),
                      ),
              );
            }),
          );
        }));
  }
}
