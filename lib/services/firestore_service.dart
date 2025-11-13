import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshetribe/models/user_model.dart';
import 'package:myshetribe/models/tribe_model.dart';
import 'package:myshetribe/models/event_model.dart';
import 'package:myshetribe/models/partnership_offer_model.dart';
import 'package:myshetribe/models/booking_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ==================== USER OPERATIONS ====================

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.uid).set(user.toFirestore());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<UserModel?> getUser(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get user: $e');
    }
  }

  Future<void> updateUser(String uid, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = Timestamp.now();
      await _firestore.collection('users').doc(uid).update(data);
    } catch (e) {
      throw Exception('Failed to update user: $e');
    }
  }

  Stream<UserModel?> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots().map((doc) {
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    });
  }

  // ==================== TRIBE OPERATIONS ====================

  Future<String> createTribe(TribeModel tribe) async {
    try {
      DocumentReference docRef = await _firestore.collection('tribes').add(tribe.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create tribe: $e');
    }
  }

  Future<TribeModel?> getTribe(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('tribes').doc(id).get();
      if (!doc.exists) return null;
      return TribeModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get tribe: $e');
    }
  }

  Future<List<TribeModel>> getAllTribes() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('tribes')
          .where('isActive', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => TribeModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get tribes: $e');
    }
  }

  Future<List<TribeModel>> getTribesByCity(String city) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('tribes')
          .where('city', isEqualTo: city)
          .where('isActive', isEqualTo: true)
          .get();

      return snapshot.docs.map((doc) => TribeModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get tribes by city: $e');
    }
  }

  Stream<List<TribeModel>> getTribesStream() {
    return _firestore
        .collection('tribes')
        .where('isActive', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => TribeModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateTribe(String id, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = Timestamp.now();
      await _firestore.collection('tribes').doc(id).update(data);
    } catch (e) {
      throw Exception('Failed to update tribe: $e');
    }
  }

  // ==================== EVENT OPERATIONS ====================

  Future<String> createEvent(EventModel event) async {
    try {
      DocumentReference docRef = await _firestore.collection('events').add(event.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create event: $e');
    }
  }

  Future<EventModel?> getEvent(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('events').doc(id).get();
      if (!doc.exists) return null;
      return EventModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get event: $e');
    }
  }

  Future<List<EventModel>> getUpcomingEvents({String? city}) async {
    try {
      Query query = _firestore
          .collection('events')
          .where('isActive', isEqualTo: true)
          .where('eventDate', isGreaterThan: Timestamp.now())
          .orderBy('eventDate', descending: false);

      if (city != null) {
        query = query.where('city', isEqualTo: city);
      }

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get upcoming events: $e');
    }
  }

  Future<List<EventModel>> getUserEvents(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('events')
          .where('attendeeIds', arrayContains: userId)
          .orderBy('eventDate', descending: false)
          .get();

      return snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user events: $e');
    }
  }

  Stream<List<EventModel>> getEventsStream({String? city}) {
    Query query = _firestore
        .collection('events')
        .where('isActive', isEqualTo: true)
        .where('eventDate', isGreaterThan: Timestamp.now())
        .orderBy('eventDate', descending: false);

    if (city != null) {
      query = query.where('city', isEqualTo: city);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => EventModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateEvent(String id, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = Timestamp.now();
      await _firestore.collection('events').doc(id).update(data);
    } catch (e) {
      throw Exception('Failed to update event: $e');
    }
  }

  Future<void> addEventAttendee(String eventId, String userId) async {
    try {
      await _firestore.collection('events').doc(eventId).update({
        'attendeeIds': FieldValue.arrayUnion([userId]),
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to add event attendee: $e');
    }
  }

  Future<void> removeEventAttendee(String eventId, String userId) async {
    try {
      await _firestore.collection('events').doc(eventId).update({
        'attendeeIds': FieldValue.arrayRemove([userId]),
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to remove event attendee: $e');
    }
  }

  // ==================== PARTNERSHIP OFFER OPERATIONS ====================

  Future<String> createPartnershipOffer(PartnershipOfferModel offer) async {
    try {
      DocumentReference docRef = await _firestore.collection('partnership_offers').add(offer.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create partnership offer: $e');
    }
  }

  Future<PartnershipOfferModel?> getPartnershipOffer(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('partnership_offers').doc(id).get();
      if (!doc.exists) return null;
      return PartnershipOfferModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get partnership offer: $e');
    }
  }

  Future<List<PartnershipOfferModel>> getActivePartnershipOffers({String? city}) async {
    try {
      Query query = _firestore
          .collection('partnership_offers')
          .where('isActive', isEqualTo: true)
          .orderBy('createdAt', descending: true);

      QuerySnapshot snapshot = await query.get();

      List<PartnershipOfferModel> offers = snapshot.docs
          .map((doc) => PartnershipOfferModel.fromFirestore(doc))
          .toList();

      // Filter by city if provided
      if (city != null) {
        offers = offers.where((offer) =>
          offer.cities.isEmpty || offer.cities.contains(city)
        ).toList();
      }

      // Filter out expired offers
      offers = offers.where((offer) => !offer.isExpired).toList();

      return offers;
    } catch (e) {
      throw Exception('Failed to get partnership offers: $e');
    }
  }

  Future<List<PartnershipOfferModel>> getFeaturedPartnershipOffers() async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('partnership_offers')
          .where('isActive', isEqualTo: true)
          .where('isFeatured', isEqualTo: true)
          .orderBy('createdAt', descending: true)
          .limit(5)
          .get();

      List<PartnershipOfferModel> offers = snapshot.docs
          .map((doc) => PartnershipOfferModel.fromFirestore(doc))
          .where((offer) => !offer.isExpired)
          .toList();

      return offers;
    } catch (e) {
      throw Exception('Failed to get featured partnership offers: $e');
    }
  }

  Stream<List<PartnershipOfferModel>> getPartnershipOffersStream() {
    return _firestore
        .collection('partnership_offers')
        .where('isActive', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => PartnershipOfferModel.fromFirestore(doc))
          .where((offer) => !offer.isExpired)
          .toList();
    });
  }

  Future<void> incrementOfferUsage(String offerId) async {
    try {
      await _firestore.collection('partnership_offers').doc(offerId).update({
        'usageCount': FieldValue.increment(1),
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      throw Exception('Failed to increment offer usage: $e');
    }
  }

  // ==================== BOOKING OPERATIONS ====================

  Future<String> createBooking(BookingModel booking) async {
    try {
      DocumentReference docRef = await _firestore.collection('bookings').add(booking.toFirestore());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  Future<BookingModel?> getBooking(String id) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('bookings').doc(id).get();
      if (!doc.exists) return null;
      return BookingModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get booking: $e');
    }
  }

  Future<List<BookingModel>> getUserBookings(String userId) async {
    try {
      QuerySnapshot snapshot = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      return snapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList();
    } catch (e) {
      throw Exception('Failed to get user bookings: $e');
    }
  }

  Stream<List<BookingModel>> getUserBookingsStream(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => BookingModel.fromFirestore(doc)).toList();
    });
  }

  Future<void> updateBooking(String id, Map<String, dynamic> data) async {
    try {
      data['updatedAt'] = Timestamp.now();
      await _firestore.collection('bookings').doc(id).update(data);
    } catch (e) {
      throw Exception('Failed to update booking: $e');
    }
  }
}
