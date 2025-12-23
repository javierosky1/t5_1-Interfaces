import 'package:flutter/material.dart';
import 'package:t5_1/model/bike_station.dart';
import 'package:t5_1/view/details_page.dart';
import 'package:t5_1/viewmodel/favorite_station_viewmodel.dart';

class StationCard extends StatelessWidget {

  final BikeStation bikeStation;
  final FavoriteStationViewmodel favoriteStationViewmodel;

  StationCard({super.key, required this.bikeStation, required this.favoriteStationViewmodel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (_) => DetailsPage(bikeStation: bikeStation, favoriteStationViewmodel: favoriteStationViewmodel)));
        },
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(bikeStation.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17
                    ),
                  ),
                  if (bikeStation.status != "IN_SERVICE" && bikeStation.status == "PLANNED") 
                    Text("(En construción)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),

                  Text("Capacidad: ${bikeStation.capacity}")
                ],
              ),
            ],
          ),
        )
      )
    );
  }
}