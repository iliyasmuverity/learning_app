import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning_app/Sign_Up_module/Student/Services/page2_service.dart';
import 'package:learning_app/navigator_key.dart';
import 'package:learning_app/main.dart';
class Page2Provider extends ChangeNotifier{
  Page2Provider({this.showProgress = false});
  int index1=0;
  List<String> litems = [];
  bool showProgress;
  void add (String cert){
    litems.add(cert);
    notifyListeners();
    index1 = index1 +1;
    notifyListeners();

  }

  void removeCertificateFromList(int idx){
    print("removing element at=====> $idx");
    print(index1);
    litems.removeAt(idx);
    notifyListeners();
    index1=index1-1;
    notifyListeners();
    print(index1);
    notifyListeners();

  }

  void submitCertificateList() async{
    showProgress = true;
    notifyListeners();
    if(litems != null && litems.isNotEmpty){
      await StudentRegistrationService2().submitListCF(litems);
      naviGet.navigatorKey.currentState.pushNamed(studentFormPage_3);

    }else{
      Fluttertoast.showToast(
        msg: "Press Skip to proceed",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green[800],
        textColor: Colors.white,
        fontSize: 18.0,

      );
    }
    showProgress = true;
    notifyListeners();

  }
}