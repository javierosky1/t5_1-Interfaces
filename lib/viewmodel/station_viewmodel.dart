import 'package:flutter/material.dart';
import 'package:t5_1/data/gbfs_repository.dart';
import 'package:t5_1/model/bike_station.dart';

class StationViewmodel extends ChangeNotifier {

  GbfsRepository _repository;
  List<BikeStation> _bikeStations = List.empty();
  List<BikeStation> get bikeStations => _bikeStations;

  StationViewmodel(this._repository);

  void getStations() {
    var response = _repository.fetchAllBikeStations();

    response.then((r) {
      _bikeStations = r;
      notifyListeners();
    });
  }
}