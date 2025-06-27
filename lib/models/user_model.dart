class User {
  final String id;
  final String email;
  final String name;
  final bool isPremium;
  final DateTime? premiumExpiry;
  final List<String>? connectedServers;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.isPremium = false,
    this.premiumExpiry,
    this.connectedServers,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      isPremium: map['isPremium'] ?? false,
      premiumExpiry: map['premiumExpiry']?.toDate(),
      connectedServers: List<String>.from(map['connectedServers'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'isPremium': isPremium,
      'premiumExpiry': premiumExpiry,
      'connectedServers': connectedServers,
    };
  }
}
