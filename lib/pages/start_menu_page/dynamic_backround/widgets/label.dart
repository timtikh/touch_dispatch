
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:touch_dispatch/pages/start_menu_page/dynamic_backround/data/synthwave_colors.dart';


class Label extends StatelessWidget {
  const Label({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: SynthwaveColors.black,
        border: Border.all(color: SynthwaveColors.blue, width: 2),
        borderRadius: BorderRadius.circular(32),
      ),
      child: Text(
        text,
        style: GoogleFonts.righteous(color: SynthwaveColors.blue, fontSize: 14),
      ),
    );
  }
}