import 'package:asyltas/app/app.locator.dart';
import 'package:asyltas/app/app.router.dart';
import 'package:asyltas/models/product.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CatalogViewmodel extends BaseViewModel {
  final _routerService = locator<RouterService>();
  Future goToMainPage() async {
    await _routerService.replaceWithHomeView();
  }

  Future goToLoginPage() async {
    await _routerService.navigateToLoginView();
  }

  Future goToRegistrationPage() async {
    await _routerService.navigateToRegistrationView();
  }

  Future goToCatalogPage() async {
    await _routerService.navigateToCatalogView();
  }

  Future goToCategoryPage(
    String? categoryId,
    String? categoryName,
  ) async {
    await _routerService.navigateToCategoryView(
      categoryId: categoryId ?? '',
      categoryName: categoryName ?? '',
    );
  }

  Future goToProductPage({
    required ProductModel product,
    required List<ProductModel> categoryProducts,
  }) async {
    await _routerService.navigateToProductView(
        product: product, categoryProducts: categoryProducts);
  }

  Future goToCartPage() async {
    await _routerService.navigateToCartView();
  }

  Future goToFavoritesPage() async {
    await _routerService.navigateToFavoritesView();
  }

  Future goToProfilePage() async {
    await _routerService.navigateToProfileView();
  }

  Future goToMenu() async {
    await _routerService.navigateToMenuView();
  }

  Future goBack() async {
    _routerService.back();
  }
}
