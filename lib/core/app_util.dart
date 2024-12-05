
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppUtil{
  static void showToast(String msg){
    Fluttertoast.showToast(msg: msg,
        backgroundColor:  const Color(0xFF000000));
  }
  static Widget flutterSpinCit(dynamic provider){
   return Center(child: provider.isLoading ?
     const SpinKitFadingCube(
       color: Colors.black,
       size: 20,
     ):const SizedBox()
  );
  }
}