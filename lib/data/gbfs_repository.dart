import 'package:t5_1/data/gbfs_api.dart';
import 'package:t5_1/model/bike_station.dart';

class GbfsRepository {
  final GbfsApi api;

  GbfsRepository(this.api);

  Future<List<BikeStation>> fetchAllBikeStations() async {
    final info = await api.getStationInfoJson();
    final status = await api.getStationStatusJson();

    List<BikeStation> returnList = [];

    for (var i = 0; i < info.length; i++) {
      if (int.parse(info[i]["station_id"]) == int.parse(status[i]["station_id"])) {
        returnList.add(BikeStation.fromJson(info[i], status[i]));
      }
    }

    return returnList;
  }

  Future<List<BikeStation>> fetchBikeStations(List<int> ids) async {
    final info = await api.getStationInfoJson();
    final status = await api.getStationStatusJson();

    List<BikeStation> returnList = [];

    for (var i = 0; i < info.length; i++) {
      for (var j = 0; j < ids.length; j++) {
        if (ids[j] == int.parse(info[i]["station_id"]) && int.parse(info[i]["station_id"]) == int.parse(status[i]["station_id"])) {
          returnList.add(BikeStation.fromJson(info[i], status[i]));
        }
      }
    }

    return returnList;
  }
}