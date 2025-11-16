import 'package:cloud_firestore/cloud_firestore.dart';

enum VerificationStatus {
  pending,
  approved,
  rejected,
}

class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String city;
  final String? country;
  final String? profileImageUrl;
  final String? verificationDocUrl;
  final String? nationality;
  final String? ageRange;
  final String? language;
  final String? profession;
  final List<String> interests;
  final String? bio;
  final List<double>? embedding;
  final List<TribeRecommendation> recommendations;
  final VerificationStatus verificationStatus;
  final String? fcmToken;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    required this.city,
    this.country,
    this.profileImageUrl,
    this.verificationDocUrl,
    this.nationality,
    this.ageRange,
    this.language,
    this.profession,
    this.interests = const [],
    this.bio,
    this.embedding,
    this.recommendations = const [],
    this.verificationStatus = VerificationStatus.pending,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  // Convert UserModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'city': city,
      'country': country,
      'profileImageUrl': profileImageUrl,
      'verificationDocUrl': verificationDocUrl,
      'nationality': nationality,
      'ageRange': ageRange,
      'language': language,
      'profession': profession,
      'interests': interests,
      'bio': bio,
      'embedding': embedding,
      'recommendations': recommendations.map((r) => r.toMap()).toList(),
      'verificationStatus': verificationStatus.name,
      'fcmToken': fcmToken,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
    };
  }

  // Create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      city: data['city'] ?? '',
      country: data['country'],
      profileImageUrl: data['profileImageUrl'],
      verificationDocUrl: data['verificationDocUrl'],
      nationality: data['nationality'],
      ageRange: data['ageRange'],
      language: data['language'],
      profession: data['profession'],
      interests: List<String>.from(data['interests'] ?? []),
      bio: data['bio'],
      embedding: data['embedding'] != null
          ? List<double>.from(data['embedding'])
          : null,
      recommendations: (data['recommendations'] as List<dynamic>?)
              ?.map((r) => TribeRecommendation.fromMap(r as Map<String, dynamic>))
              .toList() ??
          [],
      verificationStatus: _parseVerificationStatus(data['verificationStatus']),
      fcmToken: data['fcmToken'],
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['isActive'] ?? true,
    );
  }

  static VerificationStatus _parseVerificationStatus(String? status) {
    switch (status) {
      case 'approved':
        return VerificationStatus.approved;
      case 'rejected':
        return VerificationStatus.rejected;
      default:
        return VerificationStatus.pending;
    }
  }

  // Copy with method for easy updates
  UserModel copyWith({
    String? uid,
    String? email,
    String? fullName,
    String? phoneNumber,
    String? city,
    String? country,
    String? profileImageUrl,
    String? verificationDocUrl,
    String? nationality,
    String? ageRange,
    String? language,
    String? profession,
    List<String>? interests,
    String? bio,
    List<double>? embedding,
    List<TribeRecommendation>? recommendations,
    VerificationStatus? verificationStatus,
    String? fcmToken,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      city: city ?? this.city,
      country: country ?? this.country,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      verificationDocUrl: verificationDocUrl ?? this.verificationDocUrl,
      nationality: nationality ?? this.nationality,
      ageRange: ageRange ?? this.ageRange,
      language: language ?? this.language,
      profession: profession ?? this.profession,
      interests: interests ?? this.interests,
      bio: bio ?? this.bio,
      embedding: embedding ?? this.embedding,
      recommendations: recommendations ?? this.recommendations,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      fcmToken: fcmToken ?? this.fcmToken,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Tribe Recommendation model (nested in user document)
class TribeRecommendation {
  final String tribeId;
  final String tribeName;
  final double score;
  final List<String> matchReasons;

  TribeRecommendation({
    required this.tribeId,
    required this.tribeName,
    required this.score,
    this.matchReasons = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      'tribeId': tribeId,
      'tribeName': tribeName,
      'score': score,
      'matchReasons': matchReasons,
    };
  }

  factory TribeRecommendation.fromMap(Map<String, dynamic> map) {
    return TribeRecommendation(
      tribeId: map['tribeId'] ?? '',
      tribeName: map['tribeName'] ?? '',
      score: (map['score'] ?? 0.0).toDouble(),
      matchReasons: List<String>.from(map['matchReasons'] ?? []),
    );
  }
}
