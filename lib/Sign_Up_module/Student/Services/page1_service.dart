import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:learning_app/constants/constants.dart';
import 'package:learning_app/constants/preference.dart';

class StudentRegistrationService1 {
  signUp(
      {String name1,
      String name2,
      String gender,
      String branch,
      String payGrade,
      String status,
      String phone,
      String email,
      String zip,
      String password,
      String confirm,
      String resume,
      String image}) async {
    try {
//      print("Register email=======>$email");
//      print("Register name1=======>$name1");
//      print("Register name2=======>$name2");
//      print("Register gender=======>$gender");
//      print("Register branch=======>$branch");
//      print("Register payGrade=======>$payGrade");
//      print("Register status=======>$status");
//      print("Register phone=======>$phone");
//      print("Register zip=======>$zip");
//      print("Register password=======>$password");
//      print("Register confirm=======>$confirm");
//      print("Register resume=======>$resume");
//      print("Register image=======>$image");
      Map<String, String> headers = {
        'authorization': 'Bearer ${PreferenceUtils.getString(Constants.TOKEN)}',
        'Content-Type': 'application/json'
      };
      Map<String, dynamic> body2 = {
        'FirstName': '$name1',
        'LastName': '$name2',
        'Select_Gender__c': '$gender',
        'Selected_Bracnh__c': '$branch',
        'Phone': '$phone',
        'Email': '$email',
        'Zip__c': "$zip",
        'Selected_Paygrade__c': "$payGrade",
        'Selected_status__c': "$status",
        'Password__c': "$password",
        'Department': "student"
      };
      String url = "${BASE_URL}sobjects/Contact/";
      http.Response response =
          await http.post(url, headers: headers, body: jsonEncode(body2));
      var respo = jsonDecode(response.body);
      String linkedEntityId = respo['id'];
      print(respo);
      await PreferenceUtils.setString(Constants.UID, respo['id']);
      print(
          "Generated Id for your Acc. is ==========$linkedEntityId");
      Map<String, String> patchBody = {
        'Contact_Id__c': '$linkedEntityId',
      };
      String url2 =
          "${BASE_URL}sobjects/Contact/${PreferenceUtils.getString(Constants.UID)}";
      http.Response response2 =
          await http.patch(url2, headers: headers, body: jsonEncode(patchBody));
      print("Contact Id updated");
      Map<String, dynamic> body3 = {
        "Title": '$name1  $name2  Profile_Pic',
        "PathOnClient": "$name1  $name2.jpg",
        "ContentLocation": "S",
        "OwnerId": "${PreferenceUtils.getString(Constants.OWNER_ID)}",
        "VersionData": "$image"
      };
      Map<String, dynamic> body10 = {
        "Title": '$name1  $name2  Resume',
        "PathOnClient": "$name1  $name2.pdf",
        "ContentLocation": "S",
        "OwnerId": "${PreferenceUtils.getString(Constants.OWNER_ID)}",
        "VersionData": "$resume"
      };
      if (response != null && response.statusCode == 201) {
        http.Response response2 = await http.post(
            'https://muverity8-dev-ed.my.salesforce.com/services/data/v44.0/sobjects/ContentVersion',
            headers: headers,
            body: jsonEncode(body3));
        print(response2.body);
        http.Response response10 = await http.post(
            'https://muverity8-dev-ed.my.salesforce.com/services/data/v44.0/sobjects/ContentVersion',
            headers: headers,
            body: jsonEncode(body10));
        print(response10.body);
        var respo2 = jsonDecode(response2.body);
        var respo10 = jsonDecode(response10.body);
        var contentVersionId = respo2['id'];
        var contentVersionIdpdf = respo10['id'];
        await PreferenceUtils.setString(Constants.VERSION_ID, contentVersionId);
        await PreferenceUtils.setString(
            Constants.VERSION_ID_PDF, contentVersionIdpdf);
        http.Response response3 = await http.get(
          "https://muverity8-dev-ed.my.salesforce.com/services/data/v44.0/query?q=SELECT+ContentDocumentId+FROM+ContentVersion+WHERE+Id+='$contentVersionId'",
          headers: headers,
        );
        http.Response response11 = await http.get(
          "https://muverity8-dev-ed.my.salesforce.com/services/data/v44.0/query?q=SELECT+ContentDocumentId+FROM+ContentVersion+WHERE+Id+='$contentVersionIdpdf'",
          headers: headers,
        );
        respo2 = jsonDecode(response3.body);
        respo10 = jsonDecode(response11.body);
        String contentDocumentId = respo2['records'][0]['ContentDocumentId'];
        String contentDocumentIdPdf =
            respo10['records'][0]['ContentDocumentId'];
        Map<String, dynamic> body4 = {
          "ContentDocumentId": "$contentDocumentId",
          "LinkedEntityId": "${respo['id'].toString()}"
        };
        Map<String, dynamic> body11 = {
          "ContentDocumentId": "$contentDocumentIdPdf",
          "LinkedEntityId": "${respo['id'].toString()}"
        };
        http.Response response4 = await http.post(
            'https://muverity8-dev-ed.my.salesforce.com/services/data/v44.0/sobjects/ContentDocumentLink',
            headers: headers,
            body: jsonEncode(body4));
        http.Response response12 = await http.post(
            'https://muverity8-dev-ed.my.salesforce.com/services/data/v44.0/sobjects/ContentDocumentLink',
            headers: headers,
            body: jsonEncode(body11));
        print("ONE-------->" + response4.body);
        print("TWO-------->" + response12.body);
        http.Response cvResponse = await http.get(
          "https://muverity8-dev-ed.my.salesforce.com/services/data/v32.0/query/?q=SELECT ContentDocumentId,LinkedEntityId,ContentDocument.Title,ContentDocument.ContentModifiedDate, ContentDocument.ContentSize FROM ContentDocumentLink WHERE LinkedEntityId='$linkedEntityId'",
          headers: headers,
        );
        print("FOUR-------->" + cvResponse.body);
        var cvRepo = jsonDecode(cvResponse.body);
        print("FIVE-------->" + cvRepo['records'][0]['ContentDocumentId']);
        http.Response cvResponse1 = await http.get(
          "https://muverity8-dev-ed.my.salesforce.com/services/data/v42.0/"
          "query/?q=SELECT ContentDocumentId, DistributionPublicUrl,"
          "ContentDownloadUrl, Id FROM ContentDistribution"
          " where ContentDocumentId = '${cvRepo['records'][0]['ContentDocumentId']}'",
          headers: headers,
        );
        print("SIX-------->" + cvResponse1.body);
        var cvRepo1 = jsonDecode(cvResponse1.body);
        Map<String, dynamic> cvBody1 = {
          "Profile_pic_URL__c": '${cvRepo1['records'][0]['ContentDownloadUrl']}'
        };
        String url =
            "${BASE_URL}sobjects/Contact/${PreferenceUtils.getString(Constants.UID)}";
        http.Response response =
            await http.patch(url, headers: headers, body: jsonEncode(cvBody1));
        var cvRepo2 = jsonDecode(cvResponse.body);
        print("SEVEN-------->" + cvRepo['records'][1]['ContentDocumentId']);
        http.Response cvResponse2 = await http.get(
          "https://muverity8-dev-ed.my.salesforce.com/services/data/v42.0/"
              "query/?q=SELECT ContentDocumentId, DistributionPublicUrl,"
              "ContentDownloadUrl, Id FROM ContentDistribution"
              " where ContentDocumentId = '${cvRepo['records'][1]['ContentDocumentId']}'",
          headers: headers,
        );
        print("EIGHT-------->" + cvResponse2.body);
        var cvRepo3 = jsonDecode(cvResponse2.body);
        Map<String, dynamic> cvBody3 = {
          "Resume_URL__c": '${cvRepo3['records'][0]['DistributionPublicUrl']}'
        };

        http.Response response55 =
            await http.patch(url, headers: headers, body: jsonEncode(cvBody3));
      }

      print("All Done============================>       *****");
    } catch (e) {
      print(e);
    }
  }
}
