

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:learning_app/LogIn_Modue/Model/logIn_Model.dart';
import 'package:learning_app/constants/constants.dart';
import 'package:learning_app/constants/preference.dart';


class AuthService {
  Future<Contact> logIn(String email, String password) async{
    try {
      print("Login email=======>$email");
      print("Login password=======>$password");
      Map<String, String> headers = {
        'authorization': 'Bearer ${PreferenceUtils.getString(Constants.TOKEN)}',
        'Content-Type': 'application/json'
      };
      http.Response loginResponse = await http.get(
        "${BASE_URL}query/?q=SELECT+Name,Id,Profile_pic_URL__c,Resume_URL__c,Password__c,Department+FROM+Contact+where+Email='$email'",
        headers: headers,
      );
      if (loginResponse != null){
        final responseBody = jsonDecode(loginResponse.body);
        print("ResponseBody=======>$responseBody");
        return Contact.fromJson(responseBody);

      }
    } catch (e) {}
  }
}
