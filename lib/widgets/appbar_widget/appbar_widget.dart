import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Widget? leftWidget;
  final String? title;
  final Widget? rightWidget;
  final TextStyle? titleStyle;
  final EdgeInsetsGeometry? titlePadding;

  const AppBarWidget({
    super.key,
    this.leftWidget,
    this.title,
    this.rightWidget,
    this.titleStyle,
    this.titlePadding,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            leftWidget ?? const SizedBox(width: 10),
            const Spacer(),
            Animate(
              effects: const [
                ShimmerEffect(
                  color: Colors.white,
                  duration: Duration(milliseconds: 2500),
                ),
              ],
              child: Padding(
                padding: titlePadding ?? EdgeInsets.zero,
                child: Text(
                  title ?? 'dummy name',
                  style: titleStyle ??
                      GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                ).animate().scale(
                    begin: const Offset(0.4, 0.4),
                    end: const Offset(1.0, 1.0),
                    duration: 1500.ms),
              ),
            ),
            const Spacer(),
            rightWidget ?? const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0); // Default AppBar height
}
