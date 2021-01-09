import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:learning_app/Employer_module/Model/page1_model.dart';
import 'package:learning_app/constants/constants.dart';
import 'package:learning_app/constants/preference.dart';


class EmployerHomePageService {
  Future<StudentDetails> fetchstudent(int y) async{
    try{
      Map<String, String> headers = {
        'authorization': 'Bearer ${PreferenceUtils.getString(Constants.TOKEN)}',
        'Content-Type': 'application/json'
      };
      http.Response studentsList = await http.get(
        "${BASE_URL}query/?q=SELECT+Name,Id,Profile_pic_URL__c,Email,Resume_URL__c,Department,List_of_Certificates__c,Description+FROM+Contact+LIMIT $y",
        headers: headers,
      );
      if (studentsList != null){
        final responseBody = jsonDecode(studentsList.body);
        //print("ResponseBody=======>$responseBody");
        return StudentDetails.fromJson(responseBody);


      }
    }on SocketException catch (e) {
      throw SocketException('No internet connected');
    } on HttpException {
      throw HttpException('No Service found');
    } on FormatException {
      throw FormatException('Invalid data format');
    } catch (e) {
      throw Exception(e.message);
    }

  }
}