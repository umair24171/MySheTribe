import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String location;
  final String city;
  final DateTime eventDate;
  final DateTime? eventEndDate;
  final double price;
  final String? stripeCheckoutUrl;
  final int maxAttendees;
  final List<String> attendeeIds;
  final String organizerId;
  final String? tribeId;
  final String category;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isActive;

  EventModel({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.location,
    required this.city,
    required this.eventDate,
    this.eventEndDate,
    this.price = 0.0,
    this.stripeCheckoutUrl,
    this.maxAttendees = 50,
    this.attendeeIds = const [],
    required this.organizerId,
    this.tribeId,
    this.category = 'general',
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  // Check if event is full
  bool get isFull => attendeeIds.length >= maxAttendees;

  // Check if event is in the past
  bool get isPast => eventDate.isBefore(DateTime.now());

  // Check if user is attending
  bool isUserAttending(String userId) => attendeeIds.contains(userId);

  // Available spots
  int get availableSpots => maxAttendees - attendeeIds.length;

  // Convert EventModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'city': city,
      'eventDate': Timestamp.fromDate(eventDate),
      'eventEndDate': eventEndDate != null ? Timestamp.fromDate(eventEndDate!) : null,
      'price': price,
      'stripeCheckoutUrl': stripeCheckoutUrl,
      'maxAttendees': maxAttendees,
      'attendeeIds': attendeeIds,
      'organizerId': organizerId,
      'tribeId': tribeId,
      'category': category,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
    };
  }

  // Create EventModel from Firestore document
  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'],
      location: data['location'] ?? '',
      city: data['city'] ?? '',
      eventDate: (data['eventDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      eventEndDate: (data['eventEndDate'] as Timestamp?)?.toDate(),
      price: (data['price'] ?? 0.0).toDouble(),
      stripeCheckoutUrl: data['stripeCheckoutUrl'],
      maxAttendees: data['maxAttendees'] ?? 50,
      attendeeIds: List<String>.from(data['attendeeIds'] ?? []),
      organizerId: data['organizerId'] ?? '',
      tribeId: data['tribeId'],
      category: data['category'] ?? 'general',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      isActive: data['isActive'] ?? true,
    );
  }

  // Copy with method for easy updates
  EventModel copyWith({
    String? id,
    String? title,
    String? description,
    String? imageUrl,
    String? location,
    String? city,
    DateTime? eventDate,
    DateTime? eventEndDate,
    double? price,
    String? stripeCheckoutUrl,
    int? maxAttendees,
    List<String>? attendeeIds,
    String? organizerId,
    String? tribeId,
    String? category,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isActive,
  }) {
    return EventModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      location: location ?? this.location,
      city: city ?? this.city,
      eventDate: eventDate ?? this.eventDate,
      eventEndDate: eventEndDate ?? this.eventEndDate,
      price: price ?? this.price,
      stripeCheckoutUrl: stripeCheckoutUrl ?? this.stripeCheckoutUrl,
      maxAttendees: maxAttendees ?? this.maxAttendees,
      attendeeIds: attendeeIds ?? this.attendeeIds,
      organizerId: organizerId ?? this.organizerId,
      tribeId: tribeId ?? this.tribeId,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isActive: isActive ?? this.isActive,
    );
  }
}
