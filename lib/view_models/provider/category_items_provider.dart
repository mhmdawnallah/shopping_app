import 'package:flutter/material.dart';
import 'package:shop_app/services/all_services.dart';
import 'package:shop_app/services/network_helper_models/product_category_network_helper_model.dart';

class CategoryItemsProvider extends ChangeNotifier {
  Map<String, dynamic> mappingProducts = {};
  List<Product> favoriteProducts = [];

  List<ProductCategoryNetworkModel> productCategoryNetworkModelFavorites = [];
  //FavoriteProductsModified From ProductCategoryNetworkModel
  List<Product> convertedProductCategoriesNetworkModels = [];

  //Product Category Network Mode
  void addProductToProductCategoryListFavorites(
      ProductCategoryNetworkModel productCategoryNetworkModel) {
    convertAdditionProductCategoryNetworkModelToProduct(
        productCategoryNetworkModel);
    this.productCategoryNetworkModelFavorites.add(productCategoryNetworkModel);
    this.favoriteProducts.addAll(convertedProductCategoriesNetworkModels);
    notifyListeners();
  }

  void removeProductFromProductCategoryListFavorites(
      ProductCategoryNetworkModel productCategoryNetworkModel) {
    convertRemovalProductCategoryNetworkModelToProduct(
        productCategoryNetworkModel);
    this.productCategoryNetworkModelFavorites.remove(productCategoryNetworkModel);
    this.favoriteProducts.addAll(convertedProductCategoriesNetworkModels);
    notifyListeners();
  }

  void convertAdditionProductCategoryNetworkModelToProduct(
      ProductCategoryNetworkModel productCategoryNetworkModel) {
    Product product = Product(
        productId: productCategoryNetworkModel.productId,
        mediaName: productCategoryNetworkModel.mediaName,
        oriprice: productCategoryNetworkModel.price,
        discountprice: productCategoryNetworkModel.discountedPrice,
        discountindicator:
            productCategoryNetworkModel.discountedPrice.contains("0.00")
                ? Discountindicator.NO
                : Discountindicator.YES);
    this.convertedProductCategoriesNetworkModels.add(product);
    notifyListeners();
  }

  void convertRemovalProductCategoryNetworkModelToProduct(
      ProductCategoryNetworkModel productCategoryNetworkModel) {
    Product product = Product(
        productId: productCategoryNetworkModel.productId,
        mediaName: productCategoryNetworkModel.mediaName,
        oriprice: productCategoryNetworkModel.price,
        discountprice: productCategoryNetworkModel.discountedPrice,
        discountindicator:
            productCategoryNetworkModel.discountedPrice.contains("0.00")
                ? Discountindicator.NO
                : Discountindicator.YES);
    convertedProductCategoriesNetworkModels.remove(product);
    notifyListeners();
  }

  void addCategoryItemsProvider(
      List<Product> productsCategoryList, String topLabelCategoriesString) {
    mappingProducts['products'] = productsCategoryList;
    mappingProducts['topLabel'] = topLabelCategoriesString;
    notifyListeners();
  }

  void addProductToFavorites(Product favoriteProduct) {
    this.favoriteProducts.add(favoriteProduct);
    notifyListeners();
  }

  void removeProductFromFavorites(Product requiredProductToRemove) {
    favoriteProducts.remove(requiredProductToRemove);
    notifyListeners();
  }
}
