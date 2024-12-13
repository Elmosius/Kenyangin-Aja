class Location {
  final String city;
  final String address;
  final String? url;

  Location({
    required this.city,
    required this.address,
    this.url,
  });

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
