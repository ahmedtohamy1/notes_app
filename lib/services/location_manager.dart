import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:noty/services/location_services.dart';

final locationProvider = StateProvider<String?>((ref) => null);
final positionProvider = StateProvider<Position?>((ref) => null);

class LocationManager {
  final WidgetRef ref;

  LocationManager(this.ref);

  Future<void> getCurrentLocation() async {
    try {
      Position? position = await LocationService.getCurrentPosition();
      if (position != null) {
        ref.read(positionProvider.notifier).state = position;
        String? addr = await LocationService.getAddressFromLatLng(position);
        ref.read(locationProvider.notifier).state = addr;
      } else {
        ref.read(positionProvider.notifier).state = null;
        ref.read(locationProvider.notifier).state = "Location not available";
      }
    } catch (e) {
      ref.read(positionProvider.notifier).state = null;
      ref.read(locationProvider.notifier).state = "Failed to get location";
      print('Failed to get current position: $e');
    }
  }
}
