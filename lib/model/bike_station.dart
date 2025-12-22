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

  final int numBikesAvailable;
  final int numBikesDisabled;
  final String status;
  final int numDocksAvailable;
  final int numDocksDisabled;
  final bool isInstalled;
  final bool isRenting;
  final bool isReturning;
  final int fitBikesAvailable;
  final int efitBikesAvailable;
  final int boostBikesAvailable;

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
    required this.rentalUris,
    required this.numBikesAvailable,
    required this.numBikesDisabled,
    required this.status,
    required this.numDocksAvailable,
    required this.numDocksDisabled,
    required this.isInstalled,
    required this.isRenting,
    required this.isReturning,
    required this.fitBikesAvailable,
    required this.efitBikesAvailable,
    required this.boostBikesAvailable
  });

  // A lo mejor innecesario

  factory BikeStation.fromJson(Map<String, dynamic> info, Map<String, dynamic> status) {
    return BikeStation(
      id: int.parse((info["station_id"] ?? "").toString()), 
      name: (info["name"] ?? "").toString(), 
      config: (info["physical_configuration"] ?? "").toString(), 
      lat: (info["lat"] as num).toDouble(),
      lon: (info["lon"] as num).toDouble(),
      altitude: (info["altitude"]?? 0 as num).toDouble(), 
      address: (info["address"] ?? "").toString(), 
      cp: (info["post_code"] ?? "").toString(), 
      capacity: (info["capacity"] as num).toInt(), 
      isChargingStation: (info["is_charging_station"] as bool), 
      geofecedCapacity: (info["geofenced_capacity"] as num).toInt(), 
      rentalMethods: (info["rental_methods"] ?? List.empty()), 
      isVirtualStation: (info["is_virtual_station"] as bool), 
      groups: (info["rental_methods"] ?? List.empty()), 
      obcn: (info["obcn"] ?? "").toString(), 
      shortName: (info["short_name"] ?? "").toString(), 
      nearbyDistance: (info["nearby_distance"] as num).toDouble(),
      blootoothId: (info["_bluetooth_id"] ?? "").toString(), 
      rideCodeSupport: (info["_ride_code_support"] as bool), 
      rentalUris: (info["rental_uris"]),

      numBikesAvailable: int.parse(status["num_bikes_available"].toString()),
      numBikesDisabled: int.parse(status["num_bikes_disabled"].toString()),
      status: status["status"].toString(),
      numDocksAvailable: int.parse(status["num_docks_available"].toString()),
      numDocksDisabled: int.parse(status["num_docks_disabled"].toString()),
      isInstalled: (status["is_installed"] as bool),
      isRenting: (status["is_renting"] as bool),
      isReturning: (status["is_returning"] as bool),
      fitBikesAvailable: int.parse(status["vehicle_types_available"][0]["count"].toString()),
      efitBikesAvailable: int.parse(status["vehicle_types_available"][2]["count"].toString()),
      boostBikesAvailable: int.parse(status["vehicle_types_available"][1]["count"].toString()),
    );

  }
}