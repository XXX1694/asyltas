import 'package:asyltas/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:asyltas/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:asyltas/ui/views/cart/cart_view.dart';
import 'package:asyltas/ui/views/catalog/catalog_view.dart';
import 'package:asyltas/ui/views/category/category_view.dart';
import 'package:asyltas/ui/views/contacts/contacts_view.dart';
import 'package:asyltas/ui/views/favorites/favorites_view.dart';
import 'package:asyltas/ui/views/home/home_view.dart';
import 'package:asyltas/ui/views/login/login_view.dart';
import 'package:asyltas/ui/views/menu/menu_view.dart';
import 'package:asyltas/ui/views/payment/payment_view.dart';
import 'package:asyltas/ui/views/product/product_view.dart';
import 'package:asyltas/ui/views/profile/profile_view.dart';
import 'package:asyltas/ui/views/registration/registration_view.dart';
import 'package:asyltas/ui/views/unknown/unknown_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    //CustomRoute(page: StartupView, initial: true),
    CustomRoute(
      page: HomeView,
      initial: true,
      path: '/',
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: LoginView,
      transitionsBuilder: TransitionsBuilders.moveInLeft,
    ),
    CustomRoute(page: RegistrationView),
    CustomRoute(
      page: CatalogView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: CartView,
      transitionsBuilder: TransitionsBuilders.slideLeft,
    ),
    CustomRoute(page: ProfileView),
    CustomRoute(
      page: PaymentView,
      transitionsBuilder: TransitionsBuilders.slideBottom,
    ),
    CustomRoute(
      page: MenuView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: CategoryView,
      // transitionsBuilder: TransitionsBuilders.slideLeft,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(page: ContactsView),
    CustomRoute(
      page: FavoritesView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    CustomRoute(
      page: ProductView,
      transitionsBuilder: TransitionsBuilders.fadeIn,
    ),
    // @stacked-route

    CustomRoute(page: UnknownView, path: '/404'),

    /// When none of the above routes match, redirect to UnknownView
    RedirectRoute(path: '*', redirectTo: '/'),
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: RouterService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
