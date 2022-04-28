import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:qtec_ecommerce/model/cart_model.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  bool loading = false;
  int itemCount = 10;
  final TextEditingController searchController = TextEditingController(text: '');
  List<CartModel> cartValueList = [];

  bool addedToCart = false;
  int tempIndex=0;
  int cartCount=0;

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
}
