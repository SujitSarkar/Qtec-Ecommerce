import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/product_cubit.dart';
import '../variables/variables.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({Key? key,required this.index}) : super(key: key);
  final int index;

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: true);
    final double wd = MediaQuery.of(context).size.width;

    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular( wd*.05)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          //Container(color: Colors.green),
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: wd*.67,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular( wd*.05)),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: wd*.02),
              child: Column(
                children: [
                  SizedBox(height:wd*.04),
                  Image.asset('assets/p1.png',height: wd*.3),
                  SizedBox(height:wd*.03),
                  Text('লেস ক্লাসিক ফ্যামিলি সাইজ চিপস্ চিপস্',maxLines: 2,style: TextStyle(fontSize: wd*.042,height: 1.2)),
                  SizedBox(height:wd*.02),

                  Row(
                      children: [
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.start,
                            text: TextSpan(
                              style: TextStyle(fontSize: wd*.048, color: Variables.primaryColor,fontWeight: FontWeight.bold),
                              children: <TextSpan>[
                                TextSpan(text: 'ক্রয়', style: TextStyle(fontSize: wd*.03, color: Colors.grey)),
                                const TextSpan(text: ' ৳20.00'),
                              ],
                            ),
                          ),
                        ),
                        Text('৳ 22.00',textAlign: TextAlign.end, style: TextStyle(fontSize: wd*.038, color: Variables.primaryColor,decoration: TextDecoration.lineThrough))
                      ]
                  ),

                  Row(
                      children: [
                        RichText(
                          textAlign: TextAlign.start,
                          text: TextSpan(
                            style: TextStyle(fontSize: wd*.04, color: Colors.grey),
                            children: <TextSpan>[
                              TextSpan(text: 'বিক্রয়', style: TextStyle(fontSize: wd*.028,fontWeight: FontWeight.bold)),
                              const TextSpan(text: ' ৳25.00'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: RichText(
                            textAlign: TextAlign.end,
                            text: TextSpan(
                              style: TextStyle(fontSize: wd*.04, color: Colors.grey),
                              children: <TextSpan>[
                                TextSpan(text: 'লাভ', style: TextStyle(fontSize: wd*.028,fontWeight: FontWeight.bold)),
                                const TextSpan(text: ' ৳5.00'),
                              ],
                            ),
                          ),
                        ),
                      ]
                  ),
                ],
              ),
            ),
          ),

          ///Cad Section
          pc.addedToCart==true && pc.tempIndex==index
              ? Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.all(wd*.01),
                margin: EdgeInsets.symmetric(horizontal: wd*.04),
                decoration: BoxDecoration(
                  color: Variables.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular( wd*.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        pc.decrementCart(index);
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

                    Text('${pc.cartCount}  পিস',style: TextStyle(color: Variables.primaryColor,fontWeight: FontWeight.bold,fontSize: wd*.04),),

                    InkWell(
                      onTap: (){
                        pc.incrementCart(index);
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
              )
          )
              : Positioned(
            bottom: 0.0,
            child: InkWell(
              onTap: (){
                pc.changeCart(true,index);
              },
              child: Container(
                height: wd*.12,
                width: wd*.12,
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
            ),
          ),

          ///Stock Out
          Positioned(
            top: wd*.02,
            right: wd*.02,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: wd*.02,vertical: 1),
              decoration: const BoxDecoration(
                color: Variables.secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: Text('স্টকে নেই',style: TextStyle(fontSize: wd*.04,color: Variables.primaryColor)),
            ),
          )
        ],
      ),
    );
  }
}
