import 'package:connectivity_plus/connectivity_plus.dart';
import '../../config/utils/hive_managment.dart';
import '../WebServices/web_services.dart';
import '../../model/mars_photo.dart';

class Repository {
  late WebServices _webServices;
  Repository() {
    _webServices = WebServices();
  }
  Future<List<MarsPhoto>> fetchData(DateTime earthDate) async {
    var checkConnectivity = await Connectivity().checkConnectivity();
    if (checkConnectivity == ConnectivityResult.none) {
      return HiveManagment.getEarthDatePhotos(earthDate);
    } else {
      List<dynamic> fetchedData = await _webServices.fetchData(earthDate);
      List<MarsPhoto> marsPhotos =
          fetchedData.map((e) => MarsPhoto.fromJson(e)).toList();
      HiveManagment.storeMarsPhotos(marsPhotos);
      return marsPhotos;
    }
  }
}
