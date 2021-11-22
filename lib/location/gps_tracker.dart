

import 'package:location/location.dart';

class GPSTracker{
  Location location = Location();
  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;

  Future<LocationData> getLocation() async{
  //  cek apakah gps aktif
    _serviceEnabled= await location.serviceEnabled();

    // jika gpsnya tidak aktif, maka diminta untuk mengaktifkan location
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
    }

    // cek apakah aplikasi kita udah memiliki permissions untuk location
    _permissionGranted = await location.hasPermission();
    if(_permissionGranted == PermissionStatus.denied){
      // munculkan dialog untuk request permission
      _permissionGranted = await location.requestPermission();

    }

    // kembalikan data location (lat, long, dll)
    return location.getLocation();

  }
}