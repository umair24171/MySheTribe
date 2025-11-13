import 'package:cloud_firestore/cloud_firestore.dart';

class TribeModel {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final String city;
  final List<String> tags;
  final List<String> interests;
  final int memberCount;
  final double activityScore;
  final String? adminId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  TribeModel({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.city,
    this.tags = const [],
    this.interests = const [],
    this.memberCount = 0,
    this.activityScore = 0.5,
    this.adminId,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory TribeModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return TribeModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'],
      city: data['city'] ?? '',
      tags: data['tags'] != null ? List<String>.from(data['tags']) : [],
      interests: data['interests'] != null ? List<String>.from(data['interests']) : [],
      memberCount: data['memberCount'] ?? 0,
      activityScore: (data['activityScore'] ?? 0.5).toDouble(),
      adminId: data['adminId'],
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : DateTime.now(),
      isActive: data['isActive'] ?? true,
    );
  }
}
