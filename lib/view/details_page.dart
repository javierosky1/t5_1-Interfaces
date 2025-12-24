import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t5_1/model/bike_station.dart';
import 'package:t5_1/viewmodel/favorite_station_viewmodel.dart';

class DetailsPage extends StatelessWidget {
  final BikeStation bikeStation;
  final FavoriteStationViewmodel favoriteStationViewmodel;

  DetailsPage({
    super.key,
    required this.bikeStation,
    required this.favoriteStationViewmodel,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favoriteStationViewmodel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(title: Text(bikeStation.name)),
          body: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Id: ${bikeStation.id}"),
                Text("Dirección: ${bikeStation.address}"),
                Text("Código postal: ${bikeStation.cp}"),
                SizedBox(height: 20,),
                Text("Última actualización: ${bikeStation.lastReported.toString()}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 50,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: BarChart(
                        BarChartData(
                          maxY: bikeStation.capacity.toDouble(),
                          barGroups: [
                            BarChartGroupData(
                              x: bikeStation.numBikesAvailable,
                              barRods: [
                                BarChartRodData(
                                  toY: (bikeStation.numBikesAvailable + bikeStation.numBikesDisabled) != 0 ? (bikeStation.numBikesAvailable + bikeStation.numBikesDisabled).toDouble() : 0.1,
                                  rodStackItems: [
                                    BarChartRodStackItem(0, bikeStation.numBikesAvailable.toDouble(), Colors.blue),
                                    BarChartRodStackItem(bikeStation.numBikesAvailable.toDouble(), (bikeStation.numBikesAvailable + bikeStation.numBikesDisabled).toDouble(), Colors.grey)
                                  ]
                                )
                              ]
                            )
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                reservedSize: 100,
                                showTitles: true,
                                interval: 1,
                                getTitlesWidget: (value, meta) {
                                  if (value == 0 || value == bikeStation.capacity) {
                                    return Text(value.toInt().toString(), style: TextStyle(fontSize: 12),);
                                  } else if (value == (bikeStation.numBikesAvailable + bikeStation.numBikesDisabled)) {
                                    return Text("${value.toInt()} totales", style: TextStyle(fontSize: 12),);
                                  } else if (value == bikeStation.numBikesAvailable) {
                                    return Text("${value.toInt()} disponibles", style: TextStyle(fontSize: 12),);
                                  }
                                  return SizedBox.shrink();
                                },
                              )
                            )
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(
                            show: true,
                            horizontalInterval: 1,
                            checkToShowHorizontalLine: (value) => value == bikeStation.numBikesAvailable.toDouble() || value == (bikeStation.numBikesAvailable + bikeStation.numBikesDisabled).toDouble(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: PieChart(
                        PieChartData(
                          centerSpaceRadius: 0,
                          startDegreeOffset: 270,
                          sections: [
                            PieChartSectionData(
                              value: bikeStation.fitBikesAvailable.toDouble(),
                              title: "Mecánicas",
                              showTitle: true,
                              color: Colors.red
                            ),
                            PieChartSectionData(
                              value: bikeStation.efitBikesAvailable.toDouble() + bikeStation.boostBikesAvailable.toDouble(),
                              title: "Electricas",
                              showTitle: true,
                              color: Colors.blue
                            )
                          ]
                        ),
                      )
                    )
                  ],
                ),
                SizedBox(height: 50,),
                Text("¿Me compensa bajar ahora?",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                if ((bikeStation.efitBikesAvailable + bikeStation.boostBikesAvailable) > 0)
                  Text("Si, ya que hay al menos 1 bici eléctrica disponible")
                else if ((bikeStation.efitBikesAvailable + bikeStation.boostBikesAvailable) == 0 && bikeStation.fitBikesAvailable > 0)
                  Text("Quizás. Depende si te importa llegar a tu destino sin rastro de sudor")
                else
                  Text("No, ya que no hay bicis disponibles")
              ],
            ),
          ),
        );
      },
    );
  }
}