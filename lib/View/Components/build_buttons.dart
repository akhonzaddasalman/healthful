//Registration Main Button
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:healthful/View/theme/light_color.dart';

ElevatedButton buildRegisterButton(onPressed, title, {TextStyle? textStyle, ButtonStyle? style}) {
  return ElevatedButton(
    onPressed: onPressed,
    style: style ??
        ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            backgroundColor: MaterialStateProperty.all(LightColor.marron)),
    child: Text(
      title,
      style: textStyle ?? TextStyle(color: Colors.black),
    ),
  );
}

//Outlined Button
OutlinedButton buildOutlineButton(onPressed, title, {TextStyle? textStyle, ButtonStyle? buttonStyle}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: buttonStyle ??
        OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: LightColor.marron,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
    child: Text(
      title,
      style: textStyle ?? TextStyle(fontSize: 15, color: LightColor.white),
    ),
  );
}

//Outlined Button
OutlinedButton buildOutlineButtonWithIcon(onPressed, image, title, {TextStyle? textStyle, ButtonStyle? buttonStyle}) {
  return OutlinedButton(
    onPressed: onPressed,
    style: buttonStyle ??
        OutlinedButton.styleFrom(
          side: BorderSide(
            width: 1.0,
            color: LightColor.black,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
    child: Text(
      title,
      style: textStyle ??
          GoogleFonts.poppins(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: LightColor.black,
          ),
    ),
  );
}
