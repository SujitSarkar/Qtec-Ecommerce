import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:qtec_ecommerce/model/cart_model.dart';
import 'package:qtec_ecommerce/model/product_list_model.dart';
import 'package:http/http.dart' as http;
import 'package:qtec_ecommerce/variables/variables.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  bool loading = false;
  int itemCount = 10;
  int productLimit=0;
  final TextEditingController searchController = TextEditingController(text: '');
  List<CartModel> cartValueList = [];

  bool addedToCart = false;
  int tempIndex=0;
  int cartCount=0;

  FocusNode searchFocusNode = FocusNode();

  ///Details page variables
  int detailsCartCount=0;

  ProductListModel productListModel=ProductListModel();

  changeCart(bool val, int index){
    addedToCart=val;
    tempIndex=index;

    List<CartModel> tempList=[];
    tempList = cartValueList.where((element) => element.index==index).toList();
    if(tempList.isEmpty){
      cartValueList.add(CartModel(index: index, count: 1));
      cartCount=1;
    }else{
      cartCount=0;
      cartCount = tempList[0].count;
    }
    emit(ProductInitial());
  }

  incrementCart(int index){
    List<CartModel> tempList=[];
     tempList = cartValueList.where((element) => element.index==index).toList();
    if(tempList.isNotEmpty){
      cartCount = tempList[0].count+1;
      cartValueList.removeWhere((element) => element.index==index);
      cartValueList.add(CartModel(index: index, count: cartCount));
      emit(ProductInitial());
    }else{}
  }

  decrementCart(int index){
    List<CartModel> tempList=[];
    tempList = cartValueList.where((element) => element.index==index).toList();
    if(tempList.isNotEmpty){
      if(tempList[0].count>1){
        cartCount = tempList[0].count-1;
        cartValueList.removeWhere((element) => element.index==index);
        cartValueList.add(CartModel(index: index, count: cartCount));
        emit(ProductInitial());
      }else{
        cartValueList.removeWhere((element) => element.index==index);
        addedToCart = false;
        emit(ProductInitial());
      }
    }else{}
  }

  enableSearchFocusNode(){
    searchFocusNode.requestFocus();
    emit(ProductInitial());
  }

  ///Details page methods
  detailsCartIncrement(){
    detailsCartCount++;
    emit(ProductInitial());
  }

  detailsAddToCart(){
    if(detailsCartCount==0){
      detailsCartCount++;
      emit(ProductInitial());
    }
  }

  detailsCartDecrement(){
    if(detailsCartCount>0){
      detailsCartCount--;
      emit(ProductInitial());
    }
  }

  Future<void> getProductList()async{
    if(productLimit==0){loading=true;emit(ProductInitial());}
    productLimit = productLimit+10;
    print('Product Limit: $productLimit');

    try{
      http.Response response = await http.get(
          Uri.parse(Variables.baseUrl+'product/search-suggestions/?limit=10&offset=$productLimit&search=${searchController.text}'));

      if(response.statusCode==200){
        final jsonData = jsonDecode(response.body);
        if(jsonData['status'].toLowerCase()=='success'){
          productListModel = productListModelFromJson(response.body);
        }
      }
      print(productListModel.data!.products!.results!.length);
      loading=false;
      emit(ProductInitial());
    }catch(e){
     if (kDebugMode) {
       loading=false;emit(ProductInitial());
       print(e.toString());
     }
    }
  }

  Future<void> refreshProductList()async{
    productLimit = 10;
    print('Product Limit: $productLimit');

    try{
      http.Response response = await http.get(
          Uri.parse(Variables.baseUrl+'product/search-suggestions/?limit=10&offset=$productLimit&search=${searchController.text}'));

      if(response.statusCode==200){
        final jsonData = jsonDecode(response.body);
        if(jsonData['status'].toLowerCase()=='success'){
          productListModel = productListModelFromJson(response.body);
        }
      }
      print(productListModel.data!.products!.results!.length);
      emit(ProductInitial());
    }catch(e){
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
