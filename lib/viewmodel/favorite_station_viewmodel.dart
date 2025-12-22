import 'package:flutter/material.dart';
import 'package:t5_1/data/fav_station_data.dart';
import 'package:t5_1/data/gbfs_repository.dart';
import 'package:t5_1/model/bike_station.dart';

class FavoriteStationViewmodel extends ChangeNotifier {
  
  GbfsRepository _repository;
  List<int> _favoriteStationsIds = FavStationData.ids;
  List<BikeStation> _favoriteStations = List.empty();
  List<int> get favoriteStationsIds => _favoriteStationsIds;
  List<BikeStation> get favoriteStations => _favoriteStations;

  FavoriteStationViewmodel(this._repository) {
    updateStationsInfo();
  }

  void addStation(int id) {

    List<int> newFavoriteStations = List.from(_favoriteStationsIds);

    newFavoriteStations.add(id);

    _favoriteStationsIds = newFavoriteStations;

    updateStationsInfo();

  }

  void updateStationsInfo() {

    var response = _repository.fetchBikeStations(_favoriteStationsIds);

    response.then((r) => _favoriteStations = r);
  }
}