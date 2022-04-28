import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_ecommerce/blocs/product_cubit.dart';
import 'package:qtec_ecommerce/variables/variables.dart';
import '../variables/decorations.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context);
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: _bodyUI(pc,wd),
        ));
  }

  Widget _bodyUI(ProductCubit pc,double wd)=>Column(
      children: [
        SizedBox(height: wd*.08),
        ///Appbar
        Row(
          children: [
            IconButton(
              onPressed: ()=>Navigator.pop(context),
              icon: Icon(Icons.arrow_back,color:Variables.textColor,size: wd*.07,),
            ),
            Text('প্রোডাক্ট ডিটেইল',style: TextStyle(color: Variables.textColor,fontSize: wd*.052,fontWeight: FontWeight.bold))
          ],
        ),
        SizedBox(height: wd*.04),

        ///Search Field
        Padding(
          padding: EdgeInsets.symmetric(horizontal: wd*.04),
          child: TextField(
            onTap: (){
              pc.enableSearchFocusNode();
              Navigator.pop(context);
            },
            controller: pc.searchController,
            decoration: searchDecoration(wd),
          ),
        ),

      ]
  );
}
