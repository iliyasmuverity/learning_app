



import 'package:flutter/foundation.dart';
import 'package:learning_app/Employer_module/Model/page1_model.dart';
import 'package:learning_app/Employer_module/Services/page1_service.dart';

class Page1Provider extends ChangeNotifier{
  Page1Provider({this.showProgress = true});
  bool showProgress;
  String name,id,certList,description;
  StudentDetails studentDetails;
  List<Record> record;
  String cert;
  List<String> lst;
  int x=10;

  fetchStudentsDetail() async{

    print('Function Called');
    studentDetails = await EmployerHomePageService().fetchstudent(x);
    record = studentDetails.records;
    notifyListeners();
    x=x+10;

    showProgress = false;
    notifyListeners();

  }

  goBack() {
    record = null;
    x=10;
   // naviGet.navigatorKey.currentState.pushNamed(changeNotifierRouteLogIn);

  }
}