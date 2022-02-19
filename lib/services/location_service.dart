import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
// Not currently in use

class LocationService {
  bool _locationServiceEnabled = false;
  LocationPermission _permissionStatus = LocationPermission.denied;
  Position _locationData = Position.fromMap({'latitude': 0.0, 'longitude': 0.0});

  bool get serviceEnabled => _locationServiceEnabled;
  LocationPermission get permissionStatus => _permissionStatus;
  Position get locationData => _locationData;

  LocationService() {
    _init();
  }

  _init() async {
    if(permissionStatus == LocationPermission.denied) {
      getPermission();
    }
    try {
      await _checkLocationServiceEnabled();
    } catch(e) {
      debugPrint('ERROR::LocationService._init::$e');
      return;
    }
  }

  Future<void> _checkLocationServiceEnabled() async {
    _locationServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_locationServiceEnabled) {
      return Future.error('Please enable location service to continue');
    }
  }

  Future<void> getPermission() async {
    _permissionStatus = await Geolocator.checkPermission();
    if (_permissionStatus == LocationPermission.denied) {
      _permissionStatus = await Geolocator.requestPermission();
      if (_permissionStatus == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (_permissionStatus == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  Future<Position> getLocation() async {
    _locationData = await Geolocator.getCurrentPosition();

    return _locationData;
  }

  // public methods
  Future<String?> getCountryCode() async {
    List<Placemark> placemark = await placemarkFromCoordinates(_locationData.latitude, _locationData.longitude);
    return placemark.firstWhere((element) => element.isoCountryCode != "").isoCountryCode;
  }
}