import 'package:cloud_firestore/cloud_firestore.dart';

class PartnershipOfferModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String partnerName;
  final String partnerLogo;
  final String discountCode;
  final double discountPercentage;
  final String? discountAmount;
  final String category;
  final String? termsAndConditions;
  final DateTime? expiryDate;
  final String? websiteUrl;
  final String? contactEmail;
  final String? contactPhone;
  final List<String> cities; // Available in these cities
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
    required this.partnerLogo,
    required this.discountCode,
    required this.discountPercentage,
    this.discountAmount,
    required this.category,
    this.termsAndConditions,
    this.expiryDate,
    this.websiteUrl,
    this.contactEmail,
    this.contactPhone,
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
      partnerLogo: data['partnerLogo'] ?? '',
      discountCode: data['discountCode'] ?? '',
      discountPercentage: (data['discountPercentage'] ?? 0.0).toDouble(),
      discountAmount: data['discountAmount'],
      category: data['category'] ?? '',
      termsAndConditions: data['termsAndConditions'],
      expiryDate: data['expiryDate'] != null
          ? (data['expiryDate'] as Timestamp).toDate()
          : null,
      websiteUrl: data['websiteUrl'],
      contactEmail: data['contactEmail'],
      contactPhone: data['contactPhone'],
      cities: List<String>.from(data['cities'] ?? []),
      usageCount: data['usageCount'] ?? 0,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
      isFeatured: data['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'partnerName': partnerName,
      'partnerLogo': partnerLogo,
      'discountCode': discountCode,
      'discountPercentage': discountPercentage,
      'discountAmount': discountAmount,
      'category': category,
      'termsAndConditions': termsAndConditions,
      'expiryDate': expiryDate != null ? Timestamp.fromDate(expiryDate!) : null,
      'websiteUrl': websiteUrl,
      'contactEmail': contactEmail,
      'contactPhone': contactPhone,
      'cities': cities,
      'usageCount': usageCount,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
      'isFeatured': isFeatured,
    };
  }

  bool get isExpired => expiryDate != null && expiryDate!.isBefore(DateTime.now());

  PartnershipOfferModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? partnerName,
    String? partnerLogo,
    String? discountCode,
    double? discountPercentage,
    String? discountAmount,
    String? category,
    String? termsAndConditions,
    DateTime? expiryDate,
    String? websiteUrl,
    String? contactEmail,
    String? contactPhone,
    List<String>? cities,
    int? usageCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
    bool? isFeatured,
  }) {
    return PartnershipOfferModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      partnerName: partnerName ?? this.partnerName,
      partnerLogo: partnerLogo ?? this.partnerLogo,
      discountCode: discountCode ?? this.discountCode,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      discountAmount: discountAmount ?? this.discountAmount,
      category: category ?? this.category,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      expiryDate: expiryDate ?? this.expiryDate,
      websiteUrl: websiteUrl ?? this.websiteUrl,
      contactEmail: contactEmail ?? this.contactEmail,
      contactPhone: contactPhone ?? this.contactPhone,
      cities: cities ?? this.cities,
      usageCount: usageCount ?? this.usageCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
