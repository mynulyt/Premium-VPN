class Server {
  final String id;
  final String name;
  final String country;
  final String flag;
  final String configFile;
  final bool isPremium;
  final int load;
  final int ping;

  Server({
    required this.id,
    required this.name,
    required this.country,
    required this.flag,
    required this.configFile,
    this.isPremium = false,
    this.load = 0,
    this.ping = 0,
  });

  factory Server.fromMap(Map<String, dynamic> map) {
    return Server(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      country: map['country'] ?? '',
      flag: map['flag'] ?? '',
      configFile: map['configFile'] ?? '',
      isPremium: map['isPremium'] ?? false,
      load: map['load'] ?? 0,
      ping: map['ping'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country': country,
      'flag': flag,
      'configFile': configFile,
      'isPremium': isPremium,
      'load': load,
      'ping': ping,
    };
  }
}
