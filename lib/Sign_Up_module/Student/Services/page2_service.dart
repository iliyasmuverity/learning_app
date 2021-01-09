



import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:learning_app/constants/constants.dart';
import 'package:learning_app/constants/preference.dart';

class StudentRegistrationService2 {

  submitListCF( List certificates) async {
    Map<String, String> headers = {
      'authorization': 'Bearer ${PreferenceUtils.getString(Constants.TOKEN)}',
      'Content-Type':'application/json'
    };
    Map<String, dynamic> body2 = {
      "List_of_Certificates__c":certificates.toString()
    };

    try{
      String url = "${BASE_URL}sobjects/Contact/${PreferenceUtils.getString(Constants.UID)}";
      print("URL is===========>   $url");
      http.Response response = await http.patch(url, headers: headers,body: jsonEncode(body2));
      print(response.body);




//      if(response != null && response.statusCode == 201){
//
//
//
//      }

    }catch (e) {
      print(e);
      return e.toString();
    }
  }

}