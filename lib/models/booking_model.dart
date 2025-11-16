import 'package:cloud_firestore/cloud_firestore.dart';

enum BookingStatus {
  pending,
  confirmed,
  cancelled,
  refunded,
}

class BookingModel {
  final String id;
  final String userId;
  final String eventId;
  final String eventTitle;
  final DateTime eventDate;
  final double amount;
  final String? stripePaymentIntentId;
  final BookingStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;

  BookingModel({
    required this.id,
    required this.userId,
    required this.eventId,
    required this.eventTitle,
    required this.eventDate,
    required this.amount,
    this.stripePaymentIntentId,
    this.status = BookingStatus.pending,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert BookingModel to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'userId': userId,
      'eventId': eventId,
      'eventTitle': eventTitle,
      'eventDate': Timestamp.fromDate(eventDate),
      'amount': amount,
      'stripePaymentIntentId': stripePaymentIntentId,
      'status': status.name,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  // Create BookingModel from Firestore document
  factory BookingModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return BookingModel(
      id: doc.id,
      userId: data['userId'] ?? '',
      eventId: data['eventId'] ?? '',
      eventTitle: data['eventTitle'] ?? '',
      eventDate: (data['eventDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      amount: (data['amount'] ?? 0.0).toDouble(),
      stripePaymentIntentId: data['stripePaymentIntentId'],
      status: _parseBookingStatus(data['status']),
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  static BookingStatus _parseBookingStatus(String? status) {
    switch (status) {
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'cancelled':
        return BookingStatus.cancelled;
      case 'refunded':
        return BookingStatus.refunded;
      default:
        return BookingStatus.pending;
    }
  }

  // Copy with method for easy updates
  BookingModel copyWith({
    String? id,
    String? userId,
    String? eventId,
    String? eventTitle,
    DateTime? eventDate,
    double? amount,
    String? stripePaymentIntentId,
    BookingStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BookingModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      eventId: eventId ?? this.eventId,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDate: eventDate ?? this.eventDate,
      amount: amount ?? this.amount,
      stripePaymentIntentId: stripePaymentIntentId ?? this.stripePaymentIntentId,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
