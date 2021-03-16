import 'package:connect/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getMaterialTheme(context) {
  return ThemeData(
    primaryColor: AppColors.PRIMARY_COLOR,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.WHITE_COLOR,
    textTheme: GoogleFonts.nunitoTextTheme(Theme.of(context).textTheme).copyWith(
      headline6: GoogleFonts.nunito(
        textStyle: TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}
