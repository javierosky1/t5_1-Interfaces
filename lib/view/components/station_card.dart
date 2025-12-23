import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:t5_1/model/bike_station.dart';

class StationCard extends StatelessWidget {

  final BikeStation bikeStation;

  StationCard({super.key, required this.bikeStation});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: GestureDetector(
        onTap: () {},
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
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 150,
                    width: 150,
                    child: BarChart(
                      BarChartData(
                        maxY: bikeStation.capacity.toDouble(),
                        barGroups: [
                          BarChartGroupData(
                            x: bikeStation.numBikesAvailable,
                            barRods: [
                              BarChartRodData(
                                toY: bikeStation.numBikesAvailable != 0 ? bikeStation.numBikesAvailable.toDouble() : 0.1
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
                              showTitles: true,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                if (value == 0 || value == bikeStation.capacity || value == bikeStation.numBikesAvailable) {
                                  return Text(value.toInt().toString(), style: TextStyle(fontSize: 12),);
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
                          checkToShowHorizontalLine: (value) => value == bikeStation.numBikesAvailable.toDouble(),
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
              )
            ],
          ),
        )
      )
    );
  }  
}