import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../generated/l10n.dart';
import '../../model/mars_photo.dart';

class MarsPhotoContainer extends StatelessWidget {
  const MarsPhotoContainer({Key? key, required this.marsPhoto, this.isArabic})
      : super(key: key);
  final MarsPhoto marsPhoto;
  final String? isArabic;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CachedNetworkImage(
              width: double.infinity,
              height: 250,
              imageUrl: marsPhoto.imgSrc,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${S.of(context).theCamera} ${marsPhoto.camera.name}",
                style: isArabic == 'en'
                    ? const TextStyle(
                        fontFamily: 'Poppins', )
                    : const TextStyle(
                        fontFamily: 'Almarai', ),
              ),
              Text(
                "${S.of(context).theSol} ${marsPhoto.sol}",
                style: isArabic == 'en'
                    ? const TextStyle(
                        fontFamily: 'Poppins', )
                    : const TextStyle(
                        fontFamily: 'Almarai', ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "${S.of(context).earthDate} ${marsPhoto.earthDate}",
            style: isArabic == 'en'
                ? const TextStyle(
                    fontFamily: 'Poppins', )
                : const TextStyle(
                    fontFamily: 'Almarai', ),
          ),
        ],
      ),
    );
  }
}
