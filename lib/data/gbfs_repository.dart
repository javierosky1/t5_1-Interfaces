import 'package:t5_1/data/gbfs_api.dart';
import 'package:t5_1/model/bike_station.dart';

class GbfsRepository {
  final GbfsApi api;

  GbfsRepository(this.api);

  Future<List<BikeStation>> fetchAllBikeStations() async {
    final list = await api.getStationInfoJson();
    return list.map((e) => BikeStation.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<BikeStation>> fetchBikeStations(List<int> ids) async {
    final list = await api.getStationInfoJson();
    List<BikeStation> allBikeStations = list.map((e) => BikeStation.fromJson(e as Map<String, dynamic>)).toList();

    List<BikeStation> requestedBikeStations = [];

    allBikeStations.forEach((station) {
      for (var id in ids) {
        if (station.id == id) requestedBikeStations.add(station);
      }
    });

    return requestedBikeStations;
  }
}