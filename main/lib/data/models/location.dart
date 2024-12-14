class Location {
  final String city;
  final String address;
  final String? url;

  Location({
    required this.city,
    required this.address,
    this.url,
  });

  Location copyWith({String? city, String? address, String? url}) {
    return Location(
      city: city ?? this.city,
      address: address ?? this.address,
      url: url,
    );
  }

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      city: json['city'],
      address: json['address'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'address': address,
      'url': url,
    };
  }
}
