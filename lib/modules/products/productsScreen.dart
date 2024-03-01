
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/homeModel.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';
import 'package:shopapp/shared/style/colors.dart';

import '../../models/categories_models.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitApp, ShopStatesApp>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.model.status!)
            {
              ShowToast(text: state.model.message!, state: ToastStates.ERROR);
            }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          // condition: ShopCubitApp.get(context).homeModel?.data != null && ShopCubitApp.get(context).categoriesModel?.data != null,
          condition: ShopCubitApp.get(context).homeModel?.data != null,
          // condition: ShopCubitApp.get(context).homeModel != null,
          // condition: true,
          builder: (context) =>
              productsBuilder(ShopCubitApp.get(context).homeModel! , ShopCubitApp.get(context).categoriesModel! ,context ),
          fallback: (context) => const Center(
            child: CircleAvatar(),
          ),
        );
      },
    );
  }

  Widget productsBuilder(HomeModel model , CategoriesModel categoriesModel, context ) {
    if (model.data != null && model.data!.banners.isNotEmpty) {
      return SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage("${e.image}"),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 1),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                scrollDirection: Axis.horizontal,
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Categories",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategoryItem( categoriesModel.data!.data![index]),
                      separatorBuilder: (context, index) => const SizedBox(
                        width: 15.0,
                      ),
                      itemCount: categoriesModel.data!.data!.length,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "New Products",
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Container(
              color: Colors.grey.shade300,
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: 2,
                physics: NeverScrollableScrollPhysics(),
                mainAxisSpacing: 1.0,
                crossAxisSpacing: 1.0,
                // childAspectRatio: 1/0.99,
                childAspectRatio: 1 / 1.51,
                children: List.generate(
                  model.data!.products!.length,
                  (index) => buildGridProduct(
                    model.data!.products[index] , context ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('No banners available'),
      );
    }
  }

  Widget buildCategoryItem(DataModel? model) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
           Image(
            image: NetworkImage(
              "${model!.image}"
              // "https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png",
              // '${model.image}',
              // model.image,
            ),
            fit: BoxFit.cover,
            width: 100.0,
            height: 100.0,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(
              .8,
            ),
            child:  Text(
              "${model!.name}",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
  Widget buildGridProduct(ProductsModel model ,BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    "${model.image}",
                  ),
                  width: double.infinity,
                  height: 200.0,
                  // fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.all(
                      3.0,
                    ),
                    child: Text(
                      "DISCOUNT",
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(13.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${model!.name}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      height: 1.2,
                      fontSize: 14.0,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${model!.price}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          height: 1.2,
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          "${model!.oldPrice}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              height: 1.2,
                              fontSize: 10.0,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubitApp.get(context).changeFavorites(model.id!);
                          print(model.id);
                          print(model.inFavorites);
                        },
                        icon: CircleAvatar(
                          radius: 15.0,
                          backgroundColor: ShopCubitApp.get(context).favorites[model.id]! ? defaultColor : Colors.grey,
                          child: Icon(
                            // color: Colors.white,
                            Icons.favorite_border,
                            size: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
