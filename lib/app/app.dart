import 'package:asyltas/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:asyltas/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:asyltas/ui/views/cart/cart_view.dart';
import 'package:asyltas/ui/views/catalog/catalog_view.dart';
import 'package:asyltas/ui/views/home/home_view.dart';
import 'package:asyltas/ui/views/login/login_view.dart';
import 'package:asyltas/ui/views/payment/payment_view.dart';
import 'package:asyltas/ui/views/product/product_view.dart';
import 'package:asyltas/ui/views/profile/profile_view.dart';
import 'package:asyltas/ui/views/registration/registration_view.dart';
import 'package:asyltas/ui/views/startup/startup_view.dart';
import 'package:asyltas/ui/views/unknown/unknown_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
// @stacked-import

@StackedApp(
  routes: [
    CustomRoute(page: StartupView, initial: true),
    CustomRoute(
      page: HomeView,
      path: '/home',
    ),
    CustomRoute(page: LoginView, path: '/login'),
    CustomRoute(page: RegistrationView, path: '/registration'),
    CustomRoute(page: CatalogView, path: '/catalog'),
    CustomRoute(page: CartView, path: '/cart'),
    CustomRoute(page: ProfileView, path: '/profile'),
    CustomRoute(page: PaymentView, path: '/payment'),
    CustomRoute(
      page: ProductView,
      path: 'catalog/:productId',
    ),
    // @stacked-route

    CustomRoute(page: UnknownView, path: '/404'),

    /// When none of the above routes match, redirect to UnknownView
    RedirectRoute(path: '*', redirectTo: '/home'),
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
