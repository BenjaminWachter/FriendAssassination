class Target {
  final int id;
  final String? name;
  final String? means;
  final String? imageUri;

  Target({required this.id, this.name, this.means, this.imageUri});

  // Factory constructor to create a Target from a map (e.g., from JSON)
  factory Target.fromJSON(Map<String, dynamic> map) {
    return Target(
      name: map['name'] ?? 'Unknown',
      means: map['means'] ?? 'No means provided',
      imageUri: map['imageUri'] ?? '',
      id: map['id'] ?? -1,
    );
  }

  // Method to convert Target to a map (e.g., for JSON serialization)
  Map<String, dynamic> toJSON() {
    return {'name': name, 'means': means, 'imageUri': imageUri, 'id': id};
  }
}
