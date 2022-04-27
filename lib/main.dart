import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_ecommerce/blocs/product_cubit.dart';
import 'package:qtec_ecommerce/screens/search_page.dart';
import 'package:qtec_ecommerce/variables/variables.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Variables.statusBarTheme;
  Variables.portraitMood;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qtec Ecommerce',
      debugShowCheckedModeBanner: false,
      theme: Variables.themeData,
      home: MultiBlocProvider(
        providers: [
          BlocProvider<ProductCubit>(create: (context)=>ProductCubit())
        ],
        child: const SearchPage(),
      )
    );
  }
}

