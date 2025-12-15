import 'package:flutter/material.dart';
import 'package:t5_1/data/gbfs_api.dart';
import 'package:t5_1/data/gbfs_repository.dart';
import 'package:t5_1/model/bike_station.dart';

class StationViewModel extends ChangeNotifier {

  GbfsRepository _repository = GbfsRepository(GbfsApi());

  List<BikeStation> _bikeStations = List.empty();

  List<BikeStation> get bikeStations => _bikeStations;

  void getStations() {
    var response = _repository.fetchBikeStations();

    response.then((r) => _bikeStations = r);
  }
}