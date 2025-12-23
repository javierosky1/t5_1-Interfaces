import 'package:flutter/material.dart';
import 'package:t5_1/data/gbfs_api.dart';
import 'package:t5_1/data/gbfs_repository.dart';
import 'package:t5_1/view/home_page.dart';
import 'package:t5_1/viewmodel/favorite_station_viewmodel.dart';
import 'package:t5_1/viewmodel/station_viewmodel.dart';

void main() {

  GbfsRepository repository = GbfsRepository(GbfsApi());
  StationViewmodel stationViewmodel = StationViewmodel(repository);
  FavoriteStationViewmodel favoriteStationViewmodel = FavoriteStationViewmodel(repository);

  runApp(MainApp(stationViewModel: stationViewmodel, favoriteStationViewmodel: favoriteStationViewmodel,));
}

class MainApp extends StatelessWidget {

  final StationViewmodel stationViewModel;
  final FavoriteStationViewmodel favoriteStationViewmodel;

  const MainApp({super.key, required this.stationViewModel, required this.favoriteStationViewmodel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(stationViewmodel: stationViewModel, favoriteStationViewmodel: favoriteStationViewmodel,)
    );
  }
}
