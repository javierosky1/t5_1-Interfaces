import 'package:flutter/material.dart';
import 'package:t5_1/view/components/favorite_station_card.dart';
import 'package:t5_1/view/components/station_card.dart';
import 'package:t5_1/viewmodel/favorite_station_viewmodel.dart';
import 'package:t5_1/viewmodel/station_viewmodel.dart';

class HomePage extends StatelessWidget {
  final StationViewmodel stationViewmodel;
  final FavoriteStationViewmodel favoriteStationViewmodel;

  HomePage({
    super.key,
    required this.stationViewmodel,
    required this.favoriteStationViewmodel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favoriteStationViewmodel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text("T5.1"),
            actions: [
              ElevatedButton(
                onPressed: () {
                  stationViewmodel.getStations();
                  favoriteStationViewmodel.updateStationsInfo();
                }, 
                child: Text("Actualizar datos")
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Estaciones favoritas",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    if (favoriteStationViewmodel.favoriteStations.isEmpty)
                      Text("No hay estaciones favoritas")
                    else
                      Column(
                        children: favoriteStationViewmodel.favoriteStations.map((station) {
                          return FavoriteStationCard(bikeStation: station, favoriteStationViewmodel: favoriteStationViewmodel,);
                        },).toList()
                      ),
                    SizedBox(height: 20,),
                    Row(
                      children: [
                        Text(
                          "Todas las estaciones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Column(
                        children: stationViewmodel.bikeStations.map((station) {
                          return StationCard(bikeStation: station, favoriteStationViewmodel: favoriteStationViewmodel,);
                        },).toList()
                      ),
                  ],
                ),
              ),
            ),
          )
        );
      },
    );
  }
}
