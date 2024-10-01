import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:plants_app/core/theme/app_colors.dart';
import 'package:plants_app/features/cart/presentation/widgets/arrow_animation.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PaymentButton extends StatefulWidget {
  const PaymentButton({super.key});

  @override
  State<PaymentButton> createState() => _PaymentButtonState();
}

class _PaymentButtonState extends State<PaymentButton> {
  double _dragPosition = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: AppColors.darkBlueColor,
        ),
        color: AppColors.tertiaryColor.withOpacity(0.3),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  _dragPosition = (_dragPosition + details.delta.dx).clamp(
                    0.0,
                    MediaQuery.of(context).size.width * 0.65,
                  );
                });
              },
              onHorizontalDragEnd: (details) {
                if (_dragPosition >= MediaQuery.of(context).size.width * 0.5) {
                  setState(() {
                    _dragPosition = MediaQuery.of(context).size.width * 0.62;
                  });
                } else {
                  setState(() {
                    _dragPosition = 0.0;
                  });
                }
              },
              child: ArrowsButton(dragPosition: _dragPosition),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "Swipe to Pay",
              style: GoogleFonts.readexPro().copyWith(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ArrowsButton extends StatelessWidget {
  final double dragPosition;
  const ArrowsButton({super.key, required this.dragPosition});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25.w,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        transform: Matrix4.translationValues(dragPosition, 0, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.black.withOpacity(0.7),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ArrowAnimation(
              seconds: 1,
              color: Colors.white.withOpacity(0.3),
            ),
            ArrowAnimation(
              seconds: 1,
              color: Colors.white.withOpacity(0.7),
            ),
            const ArrowAnimation(
              seconds: 1,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
