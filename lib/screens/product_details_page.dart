import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polygon/flutter_polygon.dart';
import 'package:qtec_ecommerce/blocs/product_cubit.dart';
import 'package:qtec_ecommerce/variables/variables.dart';
import '../variables/decorations.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key,required this.slug}) : super(key: key);
  final String slug;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {

  @override
  void initState() {
    super.initState();
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: false);
    pc.getProductDetails(widget.slug);
  }

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: true);
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      body: pc.loading
          ? const Center(child: CircularProgressIndicator())
          : _bodyUI(pc, wd),
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
            decoration: searchDecoration(wd,pc),
          ),
        ),
    SizedBox(height: wd * .04),

    ///Product details
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
              items: pc.productDetailsModel.data!.images!.map<Widget>((item) => Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(wd*.04)),
                    color: Colors.white
                ),
                child: Center(child: CachedNetworkImage(
                    imageUrl: item.image!,
                    placeholder: (context, url) => Icon(Icons.image_outlined,color: Colors.grey,size: wd*.3),
                    errorWidget: (context, url, error) => Icon(Icons.error,size: wd*.25,color: Colors.grey),
                    fit: BoxFit.cover
                )),
              )).toList(),
            ),
            SizedBox(height: wd * .05),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: wd*.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ///Product Name
                  Text(pc.productDetailsModel.data!.productName??'',
                      style: TextStyle(
                          color: Variables.textColor,
                          fontSize: wd * .052,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: wd*.01),

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
                              TextSpan(text: ' ${pc.productDetailsModel.data!.brand!.name}  ', style: TextStyle(fontSize: wd*.034,color: Variables.textColor)),
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
                                TextSpan(text: ' ${pc.productDetailsModel.data!.seller}', style: TextStyle(fontSize: wd*.034,color: Variables.textColor)),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                  SizedBox(height: wd*.04),

                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(height: wd*.52),

                      ///ক্রয়মূল্য, বিক্রয়মূল্য, লাভ
                      Positioned(
                        top: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: wd*.04,vertical: wd*.02),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Column(
                            children: [
                              ///ক্রয়মূল্য
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('ক্রয়মূল্যঃ',
                                        style: TextStyle(color: Variables.primaryColor,fontSize: wd*.047,fontWeight: FontWeight.bold)),
                                  ),
                                  Text('৳ ${pc.productDetailsModel.data!.charge!.currentCharge}',
                                      style: TextStyle(color: Variables.primaryColor,fontSize: wd*.047,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: wd*.01),

                              ///বিক্রয়মূল্য
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('বিক্রয়মূল্যঃ',
                                      style: TextStyle(color: Variables.textColor,fontSize: wd*.04,fontWeight: FontWeight.bold)),

                                  ///Increment Decrement Button
                                  if(pc.detailsCartCount!=0)
                                  Expanded(
                                    child: Container(
                                      padding: EdgeInsets.all(wd*.01),
                                      margin: EdgeInsets.symmetric(horizontal: wd*.03),
                                      decoration: BoxDecoration(
                                        color: Variables.secondaryColor,
                                        borderRadius: BorderRadius.all(Radius.circular( wd*.1)),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: (){
                                              pc.detailsCartDecrement();
                                            },
                                            child: Container(
                                              height: wd*.1,
                                              width: wd*.1,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color:Color(0xffFFBFDD)
                                              ),
                                              child: Icon(Icons.remove,color: Colors.white,size: wd*.065),
                                            ),
                                          ),

                                          Text('${pc.detailsCartCount}  পিস',style: TextStyle(color: Variables.primaryColor,fontWeight: FontWeight.bold,fontSize: wd*.04),),

                                          InkWell(
                                            onTap: (){
                                              pc.detailsCartIncrement();
                                            },
                                            child: Container(
                                              height: wd*.1,
                                              width: wd*.1,
                                              alignment: Alignment.center,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Variables.purpleLite,
                                                        Variables.purpleDeep],
                                                      begin: Alignment.topCenter,
                                                      end: Alignment.bottomCenter
                                                  )
                                              ),
                                              child: Icon(Icons.add,color: Colors.white,size: wd*.065),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),

                                  Text('৳ ${pc.productDetailsModel.data!.charge!.sellingPrice}',
                                      style: TextStyle(color: Variables.textColor,fontSize: wd*.04,fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(height: wd*.03),

                              ///Dashed Line
                              Row(
                                children: List.generate(160~/2, (index) => Expanded(
                                  child: Container(
                                    color: index%2==0?Colors.transparent
                                        :Variables.hintColor,
                                    height: 1,
                                  ),
                                )),
                              ),
                              SizedBox(height: wd*.01),

                              ///লাভ
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text('লাভঃ',
                                        style: TextStyle(color: Variables.textColor,fontSize: wd*.04,fontWeight: FontWeight.bold)),
                                  ),
                                  Text('৳ ${pc.productDetailsModel.data!.charge!.profit}',
                                      style: TextStyle(color: Variables.textColor,fontSize: wd*.04,fontWeight: FontWeight.bold)),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),

                      ///Cart Container
                      Positioned(
                        bottom: pc.detailsCartCount!=0? 0.0 : wd*.047,
                        child: Stack(
                          children: [
                            ///Polygon Container
                            SizedBox(
                              height: wd*.27,
                              width: wd*.27,
                              child: InkWell(
                                onTap: (){
                                  pc.detailsAddToCart();
                                },
                                child: ClipPolygon(
                                  sides: 6,
                                  borderRadius: wd*.04,
                                  rotate: 180.0,
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Variables.purpleLite,
                                          Variables.purpleDeep],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter
                                      )
                                    ),
                                    child: pc.detailsCartCount!=0? Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Image.asset('assets/shopping_bag.png',height: wd*.08),
                                        Text('কার্ট',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: wd*.04),)
                                      ],
                                    )
                                    :Text('এটি\nকিনুন',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: wd*.04),),
                                  ),
                                ),
                              ),
                            ),

                            ///Cart count
                            if(pc.detailsCartCount!=0)
                            Positioned(
                              right: 0.0,
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(wd*.025),
                                decoration: BoxDecoration(
                                  color: Variables.secondaryColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white,width: 2)
                                ),
                                child: Text('${pc.detailsCartCount}',style: TextStyle(color: Variables.primaryColor,fontSize: wd*.04)),
                              ),
                            )
                          ],
                        ),
                      ),

                      ///Details Title
                      Positioned(
                        bottom: 0,
                        left:0,
                        child: Text('বিস্তারিত',style: TextStyle(color: Variables.textColor,fontSize: wd*.047,fontWeight: FontWeight.bold)),
                      )
                    ],
                  ),

                  ///Product Details
                  Html(
                    data:
                    """${pc.productDetailsModel.data!.description}""",
                    style: {
                      'strong': Style(color: Variables.textColor),
                      'body': Style(color: Variables.textColor),
                      'span': Style(color: Variables.textColor),
                      'p': Style(color: Variables.textColor),
                      'li': Style(color: Variables.textColor),
                      'ul': Style(color: Variables.textColor),
                      'table': Style(color: Variables.textColor),
                      'tbody': Style(color: Variables.textColor),
                      'tr': Style(color: Variables.textColor),
                      'td': Style(color: Variables.textColor),
                      'th': Style(color: Variables.textColor),
                      'font': Style(color: Variables.textColor)
                    },
                  )
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
