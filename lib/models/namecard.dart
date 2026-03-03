import 'package:isar/isar.dart';

part 'namecard.g.dart';

@collection
class Namecard {
  Namecard();

  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String uuid; // Unique identifier for the person

  late String name;
  String? title;
  String? email;
  String? github;
  String? linkedin;
  String? webpage;
  String? bio;
  
  // To distinguish if this is user's own card, or a received card
  bool isMine = false;
  
  DateTime? createdAt;
  DateTime? updatedAt;

  // Convert to JSON for sharing / QR code payload
  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'title': title,
      'email': email,
      'github': github,
      'linkedin': linkedin,
      'webpage': webpage,
      'bio': bio,
    };
  }

  // Create from JSON payload
  factory Namecard.fromJson(Map<String, dynamic> json) {
    return Namecard()
      ..uuid = json['uuid']
      ..name = json['name']
      ..title = json['title']
      ..email = json['email']
      ..github = json['github']
      ..linkedin = json['linkedin']
      ..webpage = json['webpage']
      ..bio = json['bio']
      ..createdAt = DateTime.now()
      ..updatedAt = DateTime.now();
  }
}
