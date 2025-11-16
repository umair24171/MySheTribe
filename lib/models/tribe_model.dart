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
  final List<double>? embedding;
  final String adminId;
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
    this.activityScore = 0.0,
    this.embedding,
    required this.adminId,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  // Convert TribeModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'city': city,
      'tags': tags,
      'interests': interests,
      'memberCount': memberCount,
      'activityScore': activityScore,
      'embedding': embedding,
      'adminId': adminId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
    };
  }

  // Create TribeModel from Firestore document
  factory TribeModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return TribeModel(
      id: doc.id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'],
      city: data['city'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      interests: List<String>.from(data['interests'] ?? []),
      memberCount: data['memberCount'] ?? 0,
      activityScore: (data['activityScore'] ?? 0.0).toDouble(),
      embedding: data['embedding'] != null
          ? List<double>.from(data['embedding'])
          : null,
      adminId: data['adminId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['isActive'] ?? true,
    );
  }

  // Copy with method for easy updates
  TribeModel copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? city,
    List<String>? tags,
    List<String>? interests,
    int? memberCount,
    double? activityScore,
    List<double>? embedding,
    String? adminId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return TribeModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      city: city ?? this.city,
      tags: tags ?? this.tags,
      interests: interests ?? this.interests,
      memberCount: memberCount ?? this.memberCount,
      activityScore: activityScore ?? this.activityScore,
      embedding: embedding ?? this.embedding,
      adminId: adminId ?? this.adminId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
