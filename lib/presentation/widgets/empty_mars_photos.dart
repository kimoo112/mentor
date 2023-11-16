
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';

class EmptyMarsPhotos extends StatelessWidget {
  final String isArabic;

  const EmptyMarsPhotos({
    super.key, required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
          child: Text(
        S.of(context).isEmpty,
        style: isArabic == 'en'
                            ? const TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600)
                            : const TextStyle(
                                fontFamily: 'Almarai',
                                fontWeight: FontWeight.w600),
      )),
    );
  }
}