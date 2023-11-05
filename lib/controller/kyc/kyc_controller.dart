import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class KycController extends GetxController {


  //  Position? _position;

  Future<Position?> getCurrentLocation() async {
    Position position = await _determinePosition();
    update();
    return position;
    // setState(() {
    //   _position = position;
    // });
  }

  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        return Future.error('Location Permissions are denied');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

}