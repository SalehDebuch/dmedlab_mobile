class Abbrevaiton {
  int? id;
  String? name;
  String? description;

  Abbrevaiton({
    this.id,
    this.name,
    this.description,
  });

  factory Abbrevaiton.fromJson(Map<String, dynamic> json) {
    return Abbrevaiton(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
