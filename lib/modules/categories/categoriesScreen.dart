import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/models/categories_models.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/cubit/cubitShop/cubit.dart';
import 'package:shopapp/shared/cubit/cubitShop/states.dart';


class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubitApp , ShopStatesApp>(
    listener:(context , state ){} ,
    builder: (context , state ){
      return ListView.separated(
        itemBuilder: (context , index) => buildCatItem(ShopCubitApp.get(context).categoriesModel!.data!.data![index]),
        separatorBuilder: (context , index ) => myDivider(),
        itemCount: ShopCubitApp.get(context).categoriesModel!.data!.data!.length!,
      );
    },
    );
  }
 Widget buildCatItem(DataModel model)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Image(
          image: NetworkImage(
            // "https://student.valuxapps.com/storage/uploads/categories/1644527120pTGA7.clothes.png",
            "${model.image}",
          ),
          width: 80.0,
          height: 80.0,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 20.0,),
        Text(
          // "data",
          "${model.name}",
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(Icons.arrow_forward_ios,),
      ],
    ),
  );
}
