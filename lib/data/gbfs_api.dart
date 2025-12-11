import 'dart:convert';
import 'package:http/http.dart' as http;

class GbfsApi {
  static const String _base = "https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl/";

  Future<List<dynamic>> getStationInfoJson() async {
    final url = Uri.parse("$_base/station_information");

    final response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('HTTP ${response.statusCode}');
    }

    final decoded = jsonDecode(response.body);

    if (decoded is! List) {
      throw Exception("Respuesta inesperada");
    }

    return decoded;
  }
}