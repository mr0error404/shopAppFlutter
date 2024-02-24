class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson({Map<String, dynamic>? json}) {
    status = json?['status'];
    data = HomeDataModel.fromJson(json: json?['data']);
  }
}

class HomeDataModel {
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromJson({Map<String, dynamic>? json}) {
    // json?['banners'].forEach(
    //   (element) {
    //     banners.add(element);
    //   },
    // );
    json?['banners'].forEach(
      (element) {
        banners.add(BannersModel.fromJson(json: element));
      },
    );
    // json?['products'].forEach(
    //   (element) {
    //     banners.add(element);
    //   },
    // );
    banners = List.from(
      json?['banners']?.map(
            (item) {
              return BannersModel.fromJson(json: item);
            },
          ) ??
          [],
    );
  }
}

class BannersModel {
  int? id;
  String? image;
  BannersModel.fromJson({Map<String, dynamic>? json}) {
    id = json?['id'];
    image = json?['image'];
  }
}

class ProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;
  bool? inFavorites;
  bool? inCart;
  ProductsModel.fromJson({Map<String, dynamic>? json}) {
    id = json?['id'];
    price = json?['price'];
    oldPrice = json?['old_price'];
    discount = json?['discount'];
    image = json?['image'];
    name = json?['name'];
    description = json?['description'];
    inFavorites = json?['in_favorites'];
    inCart = json?['in_cart'];
  }
}
