import 'package:cloud_firestore/cloud_firestore.dart';

enum VerificationStatus { pending, underReview, approved, rejected }

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
  final VerificationStatus verificationStatus;
  final String? verificationNotes;
  final String? rejectionReason;
  final DateTime? verifiedAt;
  final DateTime? rejectedAt;
  final String? fcmToken;
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
    this.verificationStatus = VerificationStatus.pending,
    this.verificationNotes,
    this.rejectionReason,
    this.verifiedAt,
    this.rejectedAt,
    this.fcmToken,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

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
      interests: data['interests'] != null ? List<String>.from(data['interests']) : [],
      bio: data['bio'],
      verificationStatus: _parseVerificationStatus(data['verificationStatus']),
      verificationNotes: data['verificationNotes'],
      rejectionReason: data['rejectionReason'],
      verifiedAt: data['verifiedAt'] != null ? (data['verifiedAt'] as Timestamp).toDate() : null,
      rejectedAt: data['rejectedAt'] != null ? (data['rejectedAt'] as Timestamp).toDate() : null,
      fcmToken: data['fcmToken'],
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : DateTime.now(),
      isActive: data['isActive'] ?? true,
    );
  }

  static VerificationStatus _parseVerificationStatus(dynamic status) {
    if (status == null) return VerificationStatus.pending;

    if (status is String) {
      switch (status.toLowerCase()) {
        case 'pending':
          return VerificationStatus.pending;
        case 'underreview':
        case 'under_review':
          return VerificationStatus.underReview;
        case 'approved':
          return VerificationStatus.approved;
        case 'rejected':
          return VerificationStatus.rejected;
        default:
          return VerificationStatus.pending;
      }
    }

    return VerificationStatus.pending;
  }

  String get verificationStatusString {
    switch (verificationStatus) {
      case VerificationStatus.pending:
        return 'Pending';
      case VerificationStatus.underReview:
        return 'Under Review';
      case VerificationStatus.approved:
        return 'Approved';
      case VerificationStatus.rejected:
        return 'Rejected';
    }
  }
}
