import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
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

  //TODO: Añadir y quitar de favoritos

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: favoriteStationViewmodel,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(bikeStation.name),
            actions: [
              if (favoriteStationViewmodel.favoriteStationsIds.contains(bikeStation.id))
                ElevatedButton(
                  onPressed: () => favoriteStationViewmodel.removeStation(bikeStation.id), 
                  child: Text("Eliminar de favoritos")
                )
              else
                ElevatedButton(
                  onPressed: () => favoriteStationViewmodel.addStation(bikeStation.id), 
                  child: Text("Añadir a favoritos")
                )
            ],
          ),
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
                  Text("No, ya que no hay bicis disponibles"),
                
                SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: () => exportToPdf(), 
                  child: Text("Exportar a pdf")
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void exportToPdf() async {
    final pdf = pw.Document();


    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(bikeStation.name, 
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 20
                )
              ),
              pw.SizedBox(height: 50),
              pw.Text("Id: ${bikeStation.id}"),
              pw.Text("Dirección: ${bikeStation.address}"),
              pw.Text("Código postal: ${bikeStation.cp}"),
              pw.Text("Capacidad: ${bikeStation.capacity}"),
              pw.SizedBox(height: 20),
              pw.Text("Datos actuales",
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 16
                )
              ),
              pw.Text("Fecha del informe: ${DateTime.now().toString()}"),
              pw.Text("Última actualización de la estación: ${bikeStation.lastReported.toString()}"),
              pw.SizedBox(height: 10),
              pw.Text("Estado: ${bikeStation.status}"),
              pw.Text("Bicis en la estación: ${bikeStation.numBikesAvailable + bikeStation.numBikesDisabled}"),
              pw.Text("\t\tde las cuales operativas: ${bikeStation.numBikesAvailable}"),
              pw.Text("\t\tde las cuales deshabilitadas. ${bikeStation.numBikesDisabled}"),
              pw.Text("Puertos vacios: ${bikeStation.numDocksAvailable}"),
              pw.Text("\t\tde los cuales deshabilitados: ${bikeStation.numBikesDisabled}"),
              pw.SizedBox(height: 10),
              pw.Text("Bicis mecánicas: ${bikeStation.fitBikesAvailable}"),
              pw.Text("Bicis eléctricas: ${bikeStation.efitBikesAvailable+ bikeStation.boostBikesAvailable}"),
            ]
          );
        }
      )
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: "${bikeStation.name}.pdf");

  }
}