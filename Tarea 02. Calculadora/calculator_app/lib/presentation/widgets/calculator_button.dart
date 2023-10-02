import 'dart:ui';
import 'package:flutter/material.dart';

class CalculatorBtn extends StatelessWidget {
  final IconData? icon;
  final String? sups;
  final String? frac;
  final String text;
  final Color backgroundColor;
  final VoidCallback? onPressed;

  const CalculatorBtn({
    this.icon,
    this.sups = '',
    this.frac = '',
    this.text = '',
    required this.backgroundColor,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onPressed,
      radius: 16,
      child: Container(
        height: 68,
        width: 84,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: (icon != null)
            ? Icon(icon, size: 35, color: Colors.white)
            : (sups != '')
                ? RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'RobotoCondensed',
                        fontWeight: FontWeight.w500,
                        fontSize: 30,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: text,
                        ),
                        TextSpan(
                          text: sups,
                          style: const TextStyle(
                            fontFamily: 'Ubuntu',
                            fontFeatures: [
                              FontFeature.enable('sups'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : (frac != '')
                    ? Text(
                        '$text/$frac',
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                          fontFeatures: <FontFeature>[
                            FontFeature.fractions(),
                          ],
                        ),
                      )
                    : Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'RobotoCondensed',
                          fontWeight: FontWeight.w500,
                          fontSize: 30,
                        ),
                      ),
      ),
    );
  }
}
