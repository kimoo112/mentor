import 'package:flutter/material.dart';

import '../../logic/cubit/fetch_data_cubit.dart';
import 'mars_photo_container.dart';

class MarsPhotosListView extends StatelessWidget {
  MarsPhotosListView({
    super.key,
    required this.fetchData, this.isArabic,
  });

  final FetchDataCubit fetchData;
  final ScrollController _scrollController = ScrollController();
   final String? isArabic;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: fetchData.marsPhotos.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MarsPhotoContainer(marsPhoto: fetchData.marsPhotos[index],isArabic: isArabic,);
            }));
  }
}
