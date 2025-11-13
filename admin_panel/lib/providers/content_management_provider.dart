import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myshetribe_admin/models/event_model.dart';
import 'package:myshetribe_admin/models/tribe_model.dart';
import 'package:myshetribe_admin/models/partnership_offer_model.dart';

class ContentManagementProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<EventModel> _events = [];
  List<TribeModel> _tribes = [];
  List<PartnershipOfferModel> _partnershipOffers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<EventModel> get events => _events;
  List<TribeModel> get tribes => _tribes;
  List<PartnershipOfferModel> get partnershipOffers => _partnershipOffers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Statistics
  int get totalEvents => _events.length;
  int get activeEvents => _events.where((e) => e.isActive).length;
  int get totalTribes => _tribes.length;
  int get activeTribes => _tribes.where((t) => t.isActive).length;
  int get totalPartnershipOffers => _partnershipOffers.length;
  int get activePartnershipOffers => _partnershipOffers.where((p) => p.isActive).length;

  Future<void> loadEvents() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('events')
          .orderBy('createdAt', descending: true)
          .get();

      _events = snapshot.docs
          .map((doc) => EventModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load events: $e';
      notifyListeners();
    }
  }

  Future<void> loadTribes() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('tribes')
          .orderBy('createdAt', descending: true)
          .get();

      _tribes = snapshot.docs
          .map((doc) => TribeModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load tribes: $e';
      notifyListeners();
    }
  }

  Future<void> loadPartnershipOffers() async {
    try {
      _isLoading = true;
      notifyListeners();

      QuerySnapshot snapshot = await _firestore
          .collection('partnership_offers')
          .orderBy('createdAt', descending: true)
          .get();

      _partnershipOffers = snapshot.docs
          .map((doc) => PartnershipOfferModel.fromFirestore(doc))
          .toList();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to load partnership offers: $e';
      notifyListeners();
    }
  }

  // Event Management
  Future<bool> createEvent(Map<String, dynamic> eventData) async {
    try {
      _isLoading = true;
      notifyListeners();

      eventData['createdAt'] = FieldValue.serverTimestamp();
      eventData['updatedAt'] = FieldValue.serverTimestamp();
      eventData['isActive'] = true;
      eventData['attendeeIds'] = [];

      await _firestore.collection('events').add(eventData);
      await loadEvents();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to create event: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateEvent(String eventId, Map<String, dynamic> eventData) async {
    try {
      _isLoading = true;
      notifyListeners();

      eventData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection('events').doc(eventId).update(eventData);
      await loadEvents();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update event: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
      await loadEvents();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete event: $e';
      notifyListeners();
      return false;
    }
  }

  // Tribe Management
  Future<bool> createTribe(Map<String, dynamic> tribeData) async {
    try {
      _isLoading = true;
      notifyListeners();

      tribeData['createdAt'] = FieldValue.serverTimestamp();
      tribeData['updatedAt'] = FieldValue.serverTimestamp();
      tribeData['isActive'] = true;
      tribeData['memberCount'] = 0;
      tribeData['activityScore'] = 0.5;

      await _firestore.collection('tribes').add(tribeData);
      await loadTribes();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to create tribe: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateTribe(String tribeId, Map<String, dynamic> tribeData) async {
    try {
      _isLoading = true;
      notifyListeners();

      tribeData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection('tribes').doc(tribeId).update(tribeData);
      await loadTribes();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update tribe: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteTribe(String tribeId) async {
    try {
      await _firestore.collection('tribes').doc(tribeId).delete();
      await loadTribes();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete tribe: $e';
      notifyListeners();
      return false;
    }
  }

  // Partnership Offer Management
  Future<bool> createPartnershipOffer(Map<String, dynamic> offerData) async {
    try {
      _isLoading = true;
      notifyListeners();

      offerData['createdAt'] = FieldValue.serverTimestamp();
      offerData['updatedAt'] = FieldValue.serverTimestamp();
      offerData['isActive'] = true;
      offerData['usageCount'] = 0;

      await _firestore.collection('partnership_offers').add(offerData);
      await loadPartnershipOffers();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to create partnership offer: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> updatePartnershipOffer(String offerId, Map<String, dynamic> offerData) async {
    try {
      _isLoading = true;
      notifyListeners();

      offerData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore.collection('partnership_offers').doc(offerId).update(offerData);
      await loadPartnershipOffers();

      _isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = 'Failed to update partnership offer: $e';
      notifyListeners();
      return false;
    }
  }

  Future<bool> deletePartnershipOffer(String offerId) async {
    try {
      await _firestore.collection('partnership_offers').doc(offerId).delete();
      await loadPartnershipOffers();
      return true;
    } catch (e) {
      _errorMessage = 'Failed to delete partnership offer: $e';
      notifyListeners();
      return false;
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
