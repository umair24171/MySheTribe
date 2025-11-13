import 'package:cloud_firestore/cloud_firestore.dart';

// Relocation Information model
class RelocationInfo {
  final String? relocatingReason;
  final String? relocatingWith;
  final String? countryFrom;
  final String? uaeEmirate;
  final String? relocatingDate;
  final String? visaApplied;
  final String? visaType;
  final String? visaInfo;
  final String? support;
  final String? buddy;

  RelocationInfo({
    this.relocatingReason,
    this.relocatingWith,
    this.countryFrom,
    this.uaeEmirate,
    this.relocatingDate,
    this.visaApplied,
    this.visaType,
    this.visaInfo,
    this.support,
    this.buddy,
  });

  factory RelocationInfo.fromMap(Map<String, dynamic> map) {
    return RelocationInfo(
      relocatingReason: map['relocatingReason'],
      relocatingWith: map['relocatingWith'],
      countryFrom: map['countryFrom'],
      uaeEmirate: map['uaeEmirate'],
      relocatingDate: map['relocatingDate'],
      visaApplied: map['visaApplied'],
      visaType: map['visaType'],
      visaInfo: map['visaInfo'],
      support: map['support'],
      buddy: map['buddy'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'relocatingReason': relocatingReason,
      'relocatingWith': relocatingWith,
      'countryFrom': countryFrom,
      'uaeEmirate': uaeEmirate,
      'relocatingDate': relocatingDate,
      'visaApplied': visaApplied,
      'visaType': visaType,
      'visaInfo': visaInfo,
      'support': support,
      'buddy': buddy,
    };
  }
}

class UserModel {
  final String uid;
  final String email;
  final String fullName;
  final String phoneNumber;
  final String? city;
  final String? country;
  final String? profileImageUrl;
  final String? verificationDocUrl;
  final String? nationality;
  final String? ageRange;
  final String? language;
  final String? profession;
  final List<String> interests;
  final String? bio;
  final List<double>? embedding; // For AI matching
  final List<TribeRecommendation> recommendations;
  final RelocationInfo? relocationInfo; // Relocation information
  final VerificationStatus verificationStatus;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  UserModel({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.phoneNumber,
    this.city,
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
    this.relocationInfo,
    this.verificationStatus = VerificationStatus.pending,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  // Factory constructor to create UserModel from Firestore document
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return UserModel(
      uid: doc.id,
      email: data['email'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      city: data['city'],
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
              ?.map((e) => TribeRecommendation.fromMap(e))
              .toList() ??
          [],
      relocationInfo: data['relocationInfo'] != null
          ? RelocationInfo.fromMap(data['relocationInfo'])
          : null,
      verificationStatus: VerificationStatus.values.firstWhere(
        (e) => e.toString() == 'VerificationStatus.${data['verificationStatus']}',
        orElse: () => VerificationStatus.pending,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
    );
  }

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toFirestore() {
    return {
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
      'recommendations': recommendations.map((e) => e.toMap()).toList(),
      'relocationInfo': relocationInfo?.toMap(),
      'verificationStatus': verificationStatus.toString().split('.').last,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
    };
  }

  // Copy with method for updating fields
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
    RelocationInfo? relocationInfo,
    VerificationStatus? verificationStatus,
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
      relocationInfo: relocationInfo ?? this.relocationInfo,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}

// Tribe Recommendation model for AI matching
class TribeRecommendation {
  final String tribeId;
  final double score;
  final String tribeName;
  final List<String> matchReasons;

  TribeRecommendation({
    required this.tribeId,
    required this.score,
    required this.tribeName,
    this.matchReasons = const [],
  });

  factory TribeRecommendation.fromMap(Map<String, dynamic> map) {
    return TribeRecommendation(
      tribeId: map['tribeId'] ?? '',
      score: (map['score'] ?? 0.0).toDouble(),
      tribeName: map['tribeName'] ?? '',
      matchReasons: List<String>.from(map['matchReasons'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tribeId': tribeId,
      'score': score,
      'tribeName': tribeName,
      'matchReasons': matchReasons,
    };
  }
}

enum VerificationStatus {
  pending,
  underReview,
  approved,
  rejected,
}
