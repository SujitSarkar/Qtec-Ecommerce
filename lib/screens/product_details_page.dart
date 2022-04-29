import 'package:carousel_slider/carousel_slider.dart';
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
  final List<String> imgList = [
    'assets/food.png',
    'assets/food.png',
    'assets/food.png',
    'assets/food.png'
  ];

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context);
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: _bodyUI(pc, wd),
    ));
  }

  Widget _bodyUI(ProductCubit pc, double wd) => Column(children: [
    SizedBox(height: wd * .04),

    ///Appbar
    Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back,
                color: Variables.textColor,
                size: wd * .07,
              ),
            ),
            Text('প্রোডাক্ট ডিটেইল',
                style: TextStyle(
                    color: Variables.textColor,
                    fontSize: wd * .052,
                    fontWeight: FontWeight.bold))
          ],
        ),
    SizedBox(height: wd * .02),

    ///Search Field
    Padding(
          padding: EdgeInsets.symmetric(horizontal: wd * .04),
          child: TextField(
            onTap: () {
              pc.enableSearchFocusNode();
              Navigator.pop(context);
            },
            controller: pc.searchController,
            decoration: searchDecoration(wd),
          ),
        ),
    SizedBox(height: wd * .04),

    Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Image Slider
            CarouselSlider(
              options: CarouselOptions(
                height: wd*.7,
                aspectRatio: 16/9,
                viewportFraction: 0.6,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
              items: imgList.map((item) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(wd*.04)),
                    color: Colors.white
                ),
                child: Center(child: Image.asset(item)),
              )).toList(),
            ),
            SizedBox(height: wd * .05),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: wd*.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Product Name
                  Text('প্রিঞ্জেলস অনিওন চিপস ৪২ গ্রাম',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: wd * .052,
                          fontWeight: FontWeight.bold)),

                  ///Brand distributor
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: TextStyle(fontSize: wd*.032, color: Colors.grey),
                            children: <TextSpan>[
                              const TextSpan(text: 'ব্রান্ডঃ'),
                              TextSpan(text: ' প্রিঞ্জেলস   ', style: TextStyle(fontSize: wd*.034,color: Variables.textColor)),
                            ],
                          ),
                        ),
                        const CircleAvatar(backgroundColor: Variables.primaryColor,radius: 3),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(fontSize: wd*.032, color: Colors.grey),
                              children: <TextSpan>[
                                const TextSpan(text: '   ডিস্ট্রিবিউটরঃ'),
                                TextSpan(text: ' মোঃ মোবারাক হোসেন', style: TextStyle(fontSize: wd*.034,color: Variables.textColor)),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    )
    ]
  );
}
