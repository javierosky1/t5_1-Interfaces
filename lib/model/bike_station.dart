class BikeStation {
  final int id;
  final String name;
  final String config;
  final double lat;
  final double lon;
  final double altitude;
  final String address;
  final String cp;
  final int capacity;
  final bool isChargingStation;
  final int geofecedCapacity;
  final List<dynamic> rentalMethods;
  final bool isVirtualStation;
  final List<dynamic> groups;
  final String obcn;
  final String shortName;
  final double nearbyDistance;
  final String blootoothId;
  final bool rideCodeSupport;
  final dynamic rentalUris;

  BikeStation({
    required this.id,
    required this.name,
    required this.config,
    required this.lat,
    required this.lon,
    required this.altitude,
    required this.address,
    required this.cp,
    required this.capacity,
    required this.isChargingStation,
    required this.geofecedCapacity,
    required this.rentalMethods,
    required this.isVirtualStation,
    required this.groups,
    required this.obcn,
    required this.shortName,
    required this.nearbyDistance,
    required this.blootoothId,
    required this.rideCodeSupport,
    required this.rentalUris
  });

  factory BikeStation.fromJson(Map<String, dynamic> json) {
    return BikeStation(
      id: int.parse((json["station_id"] ?? "").toString()), 
      name: (json["name"] ?? "").toString(), 
      config: (json["physical_configuration"] ?? "").toString(), 
      lat: (json["lat"] as num).toDouble(),
      lon: (json["lon"] as num).toDouble(),
      altitude: (json["altitude"]?? 0 as num).toDouble(), 
      address: (json["address"] ?? "").toString(), 
      cp: (json["post_code"] ?? "").toString(), 
      capacity: (json["capacity"] as num).toInt(), 
      isChargingStation: (json["is_charging_station"] as bool), 
      geofecedCapacity: (json["geofenced_capacity"] as num).toInt(), 
      rentalMethods: (json["rental_methods"] ?? List.empty() as List<dynamic>), 
      isVirtualStation: (json["is_virtual_station"] as bool), 
      groups: (json["rental_methods"] ?? List.empty() as List<dynamic>), 
      obcn: (json["obcn"] ?? "").toString(), 
      shortName: (json["short_name"] ?? "").toString(), 
      nearbyDistance: (json["nearby_distance"] as num).toDouble(),
      blootoothId: (json["_bluetooth_id"] ?? "").toString(), 
      rideCodeSupport: (json["_ride_code_support"] as bool), 
      rentalUris: (json["rental_uris"])
    );

  }
}