import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qtec_ecommerce/variables/variables.dart';

InputDecoration searchDecoration(double wd)=>InputDecoration(
    hintText: 'কাঙ্খিত পণ্যটি খুঁজুন',
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    suffixIcon: const Icon(CupertinoIcons.search, color: Variables.hintColor),
    contentPadding: EdgeInsets.symmetric(horizontal: wd*.04,vertical: wd*.03),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide.none,
    )
);