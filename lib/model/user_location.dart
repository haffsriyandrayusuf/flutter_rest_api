class UserLocation {
  final LocationStreet street;
  final String city;
  final String state;
  final String country;
  final String postcode;
  final LocationCoordinates coordinates;
  final LocationTimezone timezone;

  UserLocation({
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postcode,
    required this.coordinates,
    required this.timezone,
  });

  factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
        street: LocationStreet.fromJson(json['street']),
        city: json['city'],
        state: json['state'],
        country: json['country'],
        postcode: json['postcode'].toString(),
        coordinates: LocationCoordinates.fromJson(json['coordinates']),
        timezone: LocationTimezone.fromJson(json['timezone']),
      );
}

class LocationStreet {
  final int number;
  final String name;

  LocationStreet({
    required this.number,
    required this.name,
  });

  factory LocationStreet.fromJson(Map<String, dynamic> json) => LocationStreet(
        number: json['number'],
        name: json['name'],
      );
}

class LocationCoordinates {
  final String latitude;
  final String longitude;

  LocationCoordinates({
    required this.latitude,
    required this.longitude,
  });

  factory LocationCoordinates.fromJson(Map<String, dynamic> json) =>
      LocationCoordinates(
        latitude: json['latitude'],
        longitude: json['longitude'],
      );
}

class LocationTimezone {
  final String offset;
  final String description;

  LocationTimezone({
    required this.offset,
    required this.description,
  });

  factory LocationTimezone.fromJson(Map<String, dynamic> json) =>
      LocationTimezone(
        offset: json['offset'],
        description: json['description'],
      );
}
