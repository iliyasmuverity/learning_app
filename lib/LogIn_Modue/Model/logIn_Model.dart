// To parse this JSON data, do
//
//     final contact = contactFromJson(jsonString);

import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
  Contact({
    this.totalSize,
    this.done,
    this.records,
  });

  int totalSize;
  bool done;
  List<Record> records;

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
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
    this.resumeUrlC,
    this.passwordC,
    this.department,
  });

  Attributes attributes;
  String name;
  String id;
  String profilePicUrlC;
  String resumeUrlC;
  String passwordC;
  String department;

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    attributes: json["attributes"] == null ? null : Attributes.fromJson(json["attributes"]),
    name: json["Name"] == null ? null : json["Name"],
    id: json["Id"] == null ? null : json["Id"],
    profilePicUrlC: json["Profile_pic_URL__c"] == null ? null : json["Profile_pic_URL__c"],
    resumeUrlC: json["Resume_URL__c"] == null ? null : json["Resume_URL__c"],
    passwordC: json["Password__c"] == null ? null : json["Password__c"],
    department: json["Department"] == null ? null : json["Department"],
  );

  Map<String, dynamic> toJson() => {
    "attributes": attributes == null ? null : attributes.toJson(),
    "Name": name == null ? null : name,
    "Id": id == null ? null : id,
    "Profile_pic_URL__c": profilePicUrlC == null ? null : profilePicUrlC,
    "Resume_URL__c": resumeUrlC == null ? null : resumeUrlC,
    "Password__c": passwordC == null ? null : passwordC,
    "Department": department == null ? null : department,
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
