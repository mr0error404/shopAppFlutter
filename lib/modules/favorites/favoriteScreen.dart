import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/favorites_model.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';
import 'package:shopapp/shared/style/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitApp , ShopStatesApp>(
      listener:(context , state ){} ,
      builder: (context , state ){
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          // condition: true,
          builder: (context) => ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context , index) => buildFavItem(ShopCubitApp.get(context).favoritesModel!.data!.data![index],context),
            separatorBuilder: (context , index ) => myDivider(),
            // itemCount: ShopCubitApp.get(context).categoriesModel!.data!.data!.length,
            itemCount: ShopCubitApp.get(context).favoritesModel!.data!.data!.length!,
          ),
          fallback: (context) => Center(child: CircleAvatar(),),
        );
      },
    );
  }

  Widget buildFavItem(FavoritesData model ,context) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 100.0,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(
                  "${model.product!.image}",
                  // "https://www.ionos.com/digitalguide/fileadmin/DigitalGuide/Teaser/error-t.jpg",

                ),
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
                // fit: BoxFit.cover,
              ),
              if (model.product!.discount != 0)
              // if (1 != 0)
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
          SizedBox(width: 20.0,),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${model.product!.name}",
                  // "ابل ايفون 12 برو ماكس - 256جيجابيت, ازرق",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 1.2,
                    fontSize: 14.0,
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Text(
                      "${model.product!.price}",
                      // "298",
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
                    // if (1 != 0)
                    if (model.product!.discount != 0)
                      Text(
                        // "450",
                        "${model.product!.oldPrice}",
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
                        ShopCubitApp.get(context).changeFavorites(model.product!.id!);
                        // print(model.id);
                        // print(model.inFavorites);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: ShopCubitApp.get(context).favorites[model.product!.id]! ? defaultColor : Colors.grey,
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
    ),
  );
}
