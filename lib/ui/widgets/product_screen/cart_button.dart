import 'package:asyltas/provider/cart_provider.dart';
import 'package:asyltas/ui/common/app_colors.dart';
import 'package:asyltas/ui/views/product/product_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartButton extends StatefulWidget {
  const CartButton({
    super.key,
    required this.viewModel,
  });
  final ProductViewmodel viewModel;
  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        widget.viewModel.product.count = 1;
        context.read<CartProvider>().addItem(
              widget.viewModel.product,
            );

        showCustomSnackBar(context, 'Добавлен в корзину!');
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 22,
          vertical: 8,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: newBlack,
            )),
        child: const Center(
          child: Text(
            'В корзину',
            style: TextStyle(
              fontFamily: 'Gilroy',
              color: newBlack,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
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

    Future.delayed(const Duration(milliseconds: 1500), () {
      overlayEntry.remove();
    });
  }

  Animation<Offset> _slideAnimation() {
    final animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
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
