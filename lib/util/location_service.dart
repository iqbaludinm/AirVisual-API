import 'dart:async';

import 'package:location/location.dart';
import 'package:request_api/util/user_location.dart';

class LocationService {
  Location location = Location();
  StreamController<UserLocation> _locationStreamController =
      StreamController<UserLocation>();

  Stream<UserLocation> get locationStream => _locationStreamController.stream;

  LocationService() {
    location.requestPermission().then((permissionStatus) {
      if (permissionStatus == PermissionStatus.granted) {
        //jika ada perubahan posisi
        location.onLocationChanged.listen((locationData) {
          if (locationData != null) {
            _locationStreamController.add(UserLocation(
                latitude: locationData.latitude,
                longitude: locationData.longitude));
          }
        });
      }
    });
  }

  void dispose() => _locationStreamController.close();
}
