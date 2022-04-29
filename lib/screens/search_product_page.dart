import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:qtec_ecommerce/blocs/product_cubit.dart';
import 'package:qtec_ecommerce/variables/variables.dart';
import 'package:qtec_ecommerce/widgets/product_tile.dart';
import '../variables/decorations.dart';

class SearchProductPage extends StatefulWidget {
  const SearchProductPage({Key? key}) : super(key: key);

  @override
  State<SearchProductPage> createState() => _SearchProductPageState();
}

class _SearchProductPageState extends State<SearchProductPage> {

  final RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if(mounted) {
      //setState(() {});
    }
    _refreshController.loadComplete();
  }

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
          focusNode: pc.searchFocusNode,
        ),
      ),

      ///Product List
      Expanded(
        child: SmartRefresher(
          enablePullDown: true,
          enablePullUp: true,
          header: const WaterDropHeader(waterDropColor: Variables.primaryColor),
          footer: CustomFooter(
            builder: (BuildContext context,LoadStatus? mode){
              Widget body ;
              if(mode==LoadStatus.idle){
                body =  const Text("pull up load");
              } else if(mode==LoadStatus.loading){
                body =  const CircularProgressIndicator();
              } else if(mode == LoadStatus.failed){
                body = const Text("Load Failed!Click retry!");
              } else if(mode == LoadStatus.canLoading){
                body = const Text("release to load more");
              } else{
                body = const Text("No more Data");
              } return SizedBox(
                height: 55.0,
                child: Center(child:body),
              );
            },
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: GridView.builder(
              padding: EdgeInsets.symmetric(vertical: wd*.08,horizontal: wd*.04),
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: wd*.045,
                  mainAxisSpacing: wd*.07,
                  childAspectRatio: .6
              ),
              itemCount: 20,
              shrinkWrap: true,
              itemBuilder: (context, index)=>ProductTile(index: index)
          ),
        ),
      ),
    ]
  );
}
