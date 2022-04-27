import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qtec_ecommerce/blocs/product_cubit.dart';
import '../variables/decorations.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: true);
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: _bodyUI(pc,wd),
        ));
  }

  Widget _bodyUI(ProductCubit pc, double wd)=>Column(
    children: [
      SizedBox(height: wd*.08),
      ///Search Field
      Padding(
        padding: EdgeInsets.symmetric(horizontal: wd*.04),
        child: TextField(
          controller: pc.searchController,
          decoration: searchDecoration(wd),
        ),
      ),

      Expanded(
        child: GridView.builder(
          padding: EdgeInsets.symmetric(vertical: wd*.08,horizontal: wd*.04),
           physics: const BouncingScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: wd*.055,
              mainAxisSpacing: wd*.06,
              childAspectRatio: .62
            ),
            itemCount: 20,
            shrinkWrap: true,
            itemBuilder: (context, index)=>ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular( wd*.05)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    color: Colors.red,
                  ),

                  Column(
                    children: [
                      Image.asset('assets/p1.png',height: wd*.3,)
                    ],
                  ),
                ],
              ),
            )
        ),
      )
    ]
  );
}
