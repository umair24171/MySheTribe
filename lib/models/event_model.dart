import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String location;
  final String city;
  final DateTime eventDate;
  final DateTime eventEndDate;
  final double? price;
  final String? stripeCheckoutUrl;
  final int maxAttendees;
  final List<String> attendeeIds;
  final String organizerId;
  final String? tribeId; // Optional: event organized by a tribe
  final EventCategory category;
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
    required this.eventEndDate,
    this.price,
    this.stripeCheckoutUrl,
    this.maxAttendees = 100,
    this.attendeeIds = const [],
    required this.organizerId,
    this.tribeId,
    this.category = EventCategory.networking,
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
      eventDate: (data['eventDate'] as Timestamp).toDate(),
      eventEndDate: (data['eventEndDate'] as Timestamp).toDate(),
      price: data['price']?.toDouble(),
      stripeCheckoutUrl: data['stripeCheckoutUrl'],
      maxAttendees: data['maxAttendees'] ?? 100,
      attendeeIds: List<String>.from(data['attendeeIds'] ?? []),
      organizerId: data['organizerId'] ?? '',
      tribeId: data['tribeId'],
      category: EventCategory.values.firstWhere(
        (e) => e.toString() == 'EventCategory.${data['category']}',
        orElse: () => EventCategory.networking,
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      updatedAt: (data['updatedAt'] as Timestamp).toDate(),
      isActive: data['isActive'] ?? true,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'location': location,
      'city': city,
      'eventDate': Timestamp.fromDate(eventDate),
      'eventEndDate': Timestamp.fromDate(eventEndDate),
      'price': price,
      'stripeCheckoutUrl': stripeCheckoutUrl,
      'maxAttendees': maxAttendees,
      'attendeeIds': attendeeIds,
      'organizerId': organizerId,
      'tribeId': tribeId,
      'category': category.toString().split('.').last,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
      'isActive': isActive,
    };
  }

  bool get isFull => attendeeIds.length >= maxAttendees;
  bool get isPaid => price != null && price! > 0;

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
    EventCategory? category,
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

enum EventCategory {
  networking,
  workshop,
  social,
  wellness,
  professional,
  cultural,
  sports,
  other,
}
