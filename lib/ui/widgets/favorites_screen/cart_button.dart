import 'package:asyltas/models/product.dart';
import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/provider/favorites_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.product,
  });
  final ProductModel product;
  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      child: Container(
        height: 28,
        width: 112,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            'В корзину',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: newBlack,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ),
      onPressed: () async {
        context.read<CartProvider>().addItem(
              widget.product,
            );
        context.read<FavoritesProvider>().removeItem(widget.product);
        showCustomSnackBar(context, 'Добавлен в корзину!');
      },
    );
  }

  void showCustomSnackBar(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        right: 0,
        bottom: MediaQuery.of(context).size.height * 0.12,
        child: SlideTransition(
          position: _slideAnimation(),
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              margin: const EdgeInsets.only(right: 16),
              decoration: BoxDecoration(
                color: newBlack,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    message,
                    style: const TextStyle(color: newWhite),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(milliseconds: 1000), () {
      overlayEntry.remove();
    });
  }

  Animation<Offset> _slideAnimation() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    final animation = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    ));

    animationController.forward();
    return animation;
  }
}
