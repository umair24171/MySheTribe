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
  final double? price;
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
    this.price,
    this.stripeCheckoutUrl,
    required this.maxAttendees,
    this.attendeeIds = const [],
    required this.organizerId,
    this.tribeId,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.isActive = true,
  });

  factory EventModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return EventModel(
      id: doc.id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'],
      location: data['location'] ?? '',
      city: data['city'] ?? '',
      eventDate: data['eventDate'] != null ? (data['eventDate'] as Timestamp).toDate() : DateTime.now(),
      eventEndDate: data['eventEndDate'] != null ? (data['eventEndDate'] as Timestamp).toDate() : null,
      price: data['price']?.toDouble(),
      stripeCheckoutUrl: data['stripeCheckoutUrl'],
      maxAttendees: data['maxAttendees'] ?? 0,
      attendeeIds: data['attendeeIds'] != null ? List<String>.from(data['attendeeIds']) : [],
      organizerId: data['organizerId'] ?? '',
      tribeId: data['tribeId'],
      category: data['category'] ?? 'other',
      createdAt: data['createdAt'] != null ? (data['createdAt'] as Timestamp).toDate() : DateTime.now(),
      updatedAt: data['updatedAt'] != null ? (data['updatedAt'] as Timestamp).toDate() : DateTime.now(),
      isActive: data['isActive'] ?? true,
    );
  }

  bool get isFull => attendeeIds.length >= maxAttendees;
  bool get isPaid => price != null && price! > 0;
  int get availableSpots => maxAttendees - attendeeIds.length;
}
