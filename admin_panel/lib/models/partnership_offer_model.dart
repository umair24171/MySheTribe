import 'package:cloud_firestore/cloud_firestore.dart';

class PartnershipOfferModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String partnerName;
  final String? partnerLogo;
  final String? discountCode;
  final double? discountPercentage;
  final String category;
  final String? termsAndConditions;
  final DateTime? expiryDate;
  final String? websiteUrl;
  final String? contactEmail;
  final List<String> cities;
  final int usageCount;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;
  final bool isFeatured;

  PartnershipOfferModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.partnerName,
    this.partnerLogo,
    this.discountCode,
    this.discountPercentage,
    required this.category,
    this.termsAndConditions,
    this.expiryDate,
    this.websiteUrl,
    this.contactEmail,
    this.cities = const [],
    this.usageCount = 0,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
    this.isFeatured = false,
  });

  factory PartnershipOfferModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PartnershipOfferModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'],
      partnerName: data['partnerName'] ?? '',
      partnerLogo: data['partnerLogo'],
      discountCode: data['discountCode'],
      discountPercentage: data['discountPercentage']?.toDouble(),
      category: data['category'] ?? 'General',
      termsAndConditions: data['termsAndConditions'],
      expiryDate: data['expiryDate'] != null ? (data['expiryDate'] as Timestamp).toDate() : null,
      websiteUrl: data['websiteUrl'],
      contactEmail: data['contactEmail'],
      cities: data['cities'] != null ? List<String>.from(data['cities']) : [],
      usageCount: data['usageCount'] ?? 0,
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : DateTime.now(),
      isActive: data['isActive'] ?? true,
      isFeatured: data['isFeatured'] ?? false,
    );
  }

  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());
}
