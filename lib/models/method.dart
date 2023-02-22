class Method {
  final String? id;
  final String name;
  final String description;
  final String? logo;

  Method({
    this.id,
    required this.name,
    required this.description,
    this.logo,
  });

  factory Method.fromJson(Map<String, dynamic> data) => Method(
        id: data['_id'],
        name: data['name'],
        description: data['description'],
        logo: data['logo'],
      );
}
