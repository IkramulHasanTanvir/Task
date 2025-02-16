import 'package:flutter/material.dart';

void responsePrint(url,code,body){
  debugPrint('RESPONSE \n URL: $url \n CODE: $code \n BODY: $body');
}

void requestCheck(url,Map<String,dynamic> header,Map<String,dynamic> body){
  debugPrint('REQUEST \n URL: $url \n HEADER: $header \n BODY: $body');
}