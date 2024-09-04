import 'package:asyltas/app/app.locator.dart';
import 'package:asyltas/app/app.router.dart';
import 'package:asyltas/models/product.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class CategoryViewModel extends BaseViewModel {
  final String categoryId;
  final String categoryName;
  final _routerService = locator<RouterService>();
  Future goToMainPage() async {
    await _routerService.navigateTo(const HomeViewRoute());
  }

  Future goToLoginPage() async {
    await _routerService.navigateTo(const LoginViewRoute());
  }

  Future goToRegistrationPage() async {
    await _routerService.navigateTo(const RegistrationViewRoute());
  }

  Future goToCatalogPage() async {
    await _routerService.navigateTo(const CatalogViewRoute());
  }

  Future goToProductPage({
    required ProductModel product,
    required List<ProductModel> categoryProducts,
  }) async {
    await _routerService.navigateTo(
      ProductViewRoute(
        product: product,
        categoryProducts: categoryProducts,
      ),
    );
  }

  Future goToProfilePage() async {
    await _routerService.navigateTo(const ProfileViewRoute());
  }

  Future goToFavoritesPage() async {
    await _routerService.navigateTo(const FavoritesViewRoute());
  }

  Future goToCartPage() async {
    await _routerService.navigateTo(const CartViewRoute());
  }

  Future goToMenu() async {
    await _routerService.navigateTo(const MenuViewRoute());
  }

  CategoryViewModel({
    required this.categoryId,
    required this.categoryName,
  });
}
