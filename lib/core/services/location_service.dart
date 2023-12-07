import 'package:geolocator/geolocator.dart';

class LocationService {
  Position? currentLocation = Position(
      longitude: 10,
      latitude: 10,
      timestamp: null,
      accuracy: 0,
      altitude: 0,
      altitudeAccuracy: 0,
      heading: 0,
      headingAccuracy: 0,
      speed: 0,
      speedAccuracy: 0);

  LocationService() {
    init();
  }

  init() async {
    currentLocation = await determinePosition();
  }

  determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
      }
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  distance(otherLat, otherLong, currentLat, currentLong) async {
    return await Geolocator.distanceBetween(
        otherLat, otherLong, currentLat, currentLong);
  }
}
