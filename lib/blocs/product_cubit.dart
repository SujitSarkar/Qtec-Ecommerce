import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  bool loading = false;
  int itemCount = 10;
  final TextEditingController searchController = TextEditingController(text: '');
}
