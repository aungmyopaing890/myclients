// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class UtilsPrint {
  static void printGetLog(String url, int statusCode, dynamic response) {
    const String success = '✅';
    const String failed = '❌';
    debugPrint(' ');
    debugPrint(
        '____________________________________________________________________________________________');
    debugPrint('\u001b[33m GET    --> ${url.toString()} ');
    debugPrint('\u001b[37m RESPONSE --> ${response.toString()} \u001b[0m');

    if (statusCode == 201 || statusCode == 200) {
      debugPrint('\u001b[33m $statusCode $success <-- $url\u001b[0m');
    } else if (statusCode == 204)
      debugPrint(
          '\u001b[33m $statusCode $success (Totally No Record) <-- $url\u001b[0m');
    else
      debugPrint('\u001b[33m $statusCode $failed <-- $url\u001b[0m');
    debugPrint(
        '____________________________________________________________________________________________');
    debugPrint('');
  }

  static printPostLog(String url, int statusCode, dynamic response,
      Map<dynamic, dynamic> jsonMap) {
    const String success = '✅';
    const String failed = '❌';
    debugPrint(
        '____________________________________________________________________________________________');
    debugPrint('\u001b[33m POST   --> $url\u001b[0m ');
    debugPrint('\u001b[37m REQ-BODY --> ${jsonMap.toString()} \u001b[0m');
    debugPrint('');
    debugPrint('\u001b[37m RESPONSE --> ${response.toString()} \u001b[0m');

    if (statusCode == 201 || statusCode == 200) {
      debugPrint('\u001b[33m $statusCode $success <-- $url\u001b[0m');
    } else if (statusCode == 204)
      debugPrint(
          '\u001b[33m $statusCode $success (Totally No Record) <-- $response\u001b[0m');
    else
      debugPrint('\u001b[33m $statusCode $failed <-- $url\u001b[0m');
    debugPrint(
        '____________________________________________________________________________________________');
    debugPrint('');
  }
}
