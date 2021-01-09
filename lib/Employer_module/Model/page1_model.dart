// To parse this JSON data, do
//
//     final studentDetails = studentDetailsFromJson(jsonString);

import 'dart:convert';

StudentDetails studentDetailsFromJson(String str) => StudentDetails.fromJson(json.decode(str));

String studentDetailsToJson(StudentDetails data) => json.encode(data.toJson());

class StudentDetails {
  StudentDetails({
    this.totalSize,
    this.done,
    this.records,
  });

  int totalSize;
  bool done;
  List<Record> records;

  factory StudentDetails.fromJson(Map<String, dynamic> json) => StudentDetails(
    totalSize: json["totalSize"] == null ? null : json["totalSize"],
    done: json["done"] == null ? null : json["done"],
    records: json["records"] == null ? null : List<Record>.from(json["records"].map((x) => Record.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "totalSize": totalSize == null ? null : totalSize,
    "done": done == null ? null : done,
    "records": records == null ? null : List<dynamic>.from(records.map((x) => x.toJson())),
  };
}

class Record {
  Record({
    this.attributes,
    this.name,
    this.id,
    this.profilePicUrlC,
    this.email,
    this.resumeUrlC,
    this.department,
    this.listOfCertificatesC,
    this.description,
  });

  Attributes attributes;
  String name;
  String id;
  String profilePicUrlC;
  String email;
  String resumeUrlC;
  String department;
  String listOfCertificatesC;
  String description;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
    name: json["Name"] == null ? null : json["Name"],
    id: json["Id"] == null ? null : json["Id"],
    profilePicUrlC: json["Profile_pic_URL__c"] == null ? null : json["Profile_pic_URL__c"],
    email: json["Email"] == null ? null : json["Email"],
    resumeUrlC: json["Resume_URL__c"] == null ? null : json["Resume_URL__c"],
    department: json["Department"] == null ? null : json["Department"],
    listOfCertificatesC: json["List_of_Certificates__c"] == null ? null : json["List_of_Certificates__c"],
    description: json["Description"] == null ? null : json["Description"],
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? null : attributes.toJson(),
    "Name": name == null ? null : name,
    "Id": id == null ? null : id,
    "Profile_pic_URL__c": profilePicUrlC == null ? null : profilePicUrlC,
    "Email": email == null ? null : email,
    "Resume_URL__c": resumeUrlC == null ? null : resumeUrlC,
    "Department": department == null ? null : department,
    "List_of_Certificates__c": listOfCertificatesC == null ? null : listOfCertificatesC,
    "Description": description == null ? null : description,
  };
}

class Attributes {
  Attributes({
    this.type,
    this.url,
  });

  String type;
  String url;

  factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
    type: json["type"] == null ? null : json["type"],
    url: json["url"] == null ? null : json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": type == null ? null : type,
    "url": url == null ? null : url,
  };
}
