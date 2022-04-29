import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qtec_ecommerce/blocs/product_cubit.dart';
import 'package:qtec_ecommerce/variables/variables.dart';

InputDecoration searchDecoration(double wd, ProductCubit pc)=>InputDecoration(
    hintText: 'কাঙ্খিত পণ্যটি খুঁজুন',
    fillColor: Colors.white,
    filled: true,
    isDense: true,
    suffixIcon: InkWell(onTap:()async{await pc.getProductList(isSearch: 'true');},child: const Icon(CupertinoIcons.search, color: Variables.hintColor)),
    contentPadding: EdgeInsets.symmetric(horizontal: wd*.04,vertical: wd*.03),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(15.0)),
      borderSide: BorderSide.none,
    )
);