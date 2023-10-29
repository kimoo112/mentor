
import 'package:hive/hive.dart';

import '../../model/mars_photo.dart';
import 'strings.dart';

class HiveManagment {
  static void storeMarsPhotos(List<MarsPhoto> marsPhotos) {
    for (MarsPhoto photo in marsPhotos) {
      Hive.box<MarsPhoto>(photosBox).put(photo.id, photo);
    }
  }

  static List<MarsPhoto> getEarthDatePhotos(DateTime earthDate) {
    return Hive.box<MarsPhoto>(photosBox)
        .values
        .where((element) => earthDate == element.earthDate)
        .toList();
  }
}
