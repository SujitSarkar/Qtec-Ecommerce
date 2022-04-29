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
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: false);
    pc.searchController.clear();
    await pc.refreshProductList();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async{
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: false);
    await pc.getProductList();
    // if(mounted) {
    //   setState(() {});
    // }
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    super.initState();
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: false);
    pc.getProductList();
  }

  @override
  Widget build(BuildContext context) {
    final ProductCubit pc = BlocProvider.of<ProductCubit>(context,listen: true);
    final double wd = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
          body: pc.loading
              ? const Center(child: CircularProgressIndicator())
              : _bodyUI(pc,wd),
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
          decoration: searchDecoration(wd,pc),
          focusNode: pc.searchFocusNode,
          onSubmitted: (val)async{
            await pc.getProductList(isSearch: 'true');
          },
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
              itemCount: pc.productListModel.data!.products!.results!.length,
              shrinkWrap: true,
              itemBuilder: (context, index)=>ProductTile(index: index,result:pc.productListModel.data!.products!.results![index])
          ),
        ),
      ),
    ]
  );
}
