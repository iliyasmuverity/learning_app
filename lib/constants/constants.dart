import 'dart:io';
import 'package:flutter/material.dart';

final String BASE_URL = 'https://muverity8-dev-ed.my.salesforce.com/services/data/v42.0/';
final deviceInfo = Platform.isAndroid ? 'ANDROID' : 'IOS';

Color themeColor = Color(0xff293847);

class Constants {

  static const String TOKEN = "token";
  static const String UID = "uid";
  static const String OWNER_ID = "owner_id";
  static const String VERSION_ID = "version_id";
  static const String VERSION_ID_PDF = "version_id_pdf";
  static const String RECORD_LENGTH = "record_length";
}
var items4 = [
  "Active Duty",
  "Separated",
  "National Guard",
  "Reservist",
  "Retired",
  "Spouse",
  "Other",
];

var items3 = [
  "E-1",
  "E-2",
  "E-3",
  "E-4",
  "E-5",
  "E-6",
  "E-7",
  "E-8",
  "E-9",
  "W-1",
  "W-2",
  "W-3",
  "W-4",
  "W-5",
  "O-1E",
  "O-2E",
  "O-3E",
  "0-1",
  "0-2",
  "0-3",
  "0-4",
  "0-5",
  "0-6",
  "0-7",
  "0-8",
  "0-9",
  "0-10",
  "OT",
  "SP",
  "Others",
];

var items2 = [
  "Army",
  "Air Force",
  "Coast Guard",
  "Marines",
  "Navy",
  "Merchant Marines",
  "Spouse/Family",
  "DoD Civilian",
  "other",
];

var items1 = [
  "Male",
  "Female",
];