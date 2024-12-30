import 'package:flutter_riverpod/flutter_riverpod.dart';

// StateNotifier for managing selected city
class CityNotifier extends StateNotifier<String> {
  CityNotifier() : super("Bandung");

  void setCity(String city) {
    state = city;
  }
}

final cityProvider = StateNotifierProvider<CityNotifier, String>((ref) {
  return CityNotifier();
});
