
import 'package:flutter/material.dart';

import 'colors.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        RichText(
          text: const TextSpan(
            text: 'Catalogo ',
            style: TextStyle(
              color: kSecondaryClr,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: 'floral',
                style: TextStyle(
                  color: kBlackClr,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
        const CircleAvatar(
          backgroundColor: kLightGrayClr,
          child: Icon(
            Icons.local_florist_outlined,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}