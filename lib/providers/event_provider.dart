import 'package:flutter/foundation.dart';
import 'package:myshetribe/models/event_model.dart';
import 'package:myshetribe/models/booking_model.dart';
import 'package:myshetribe/services/firestore_service.dart';
import 'package:myshetribe/services/analytics_service.dart';

class EventProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  List<EventModel> _events = [];
  List<EventModel> _myEvents = [];
  List<BookingModel> _myBookings = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<EventModel> get events => _events;
  List<EventModel> get myEvents => _myEvents;
  List<BookingModel> get myBookings => _myBookings;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Alias getters for compatibility
  List<EventModel> get upcomingEvents => _events;
  EventModel? get featuredEvent => _events.isNotEmpty ? _events.first : null;

  // Load upcoming events
  Future<void> loadUpcomingEvents({String? city}) async {
    try {
      _isLoading = true;
      notifyListeners();

      _events = await _firestoreService.getUpcomingEvents(city: city);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Alias method for compatibility
  Future<void> loadEvents({String? city}) async {
    await loadUpcomingEvents(city: city);
  }

  // Load user events
  Future<void> loadMyEvents(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _myEvents = await _firestoreService.getUserEvents(userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Alias method for compatibility
  Future<void> loadUserEvents(String userId) async {
    await loadMyEvents(userId);
  }

  // Load user bookings
  Future<void> loadMyBookings(String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      _myBookings = await _firestoreService.getUserBookings(userId);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Get event by ID
  Future<EventModel?> getEvent(String id) async {
    try {
      return await _firestoreService.getEvent(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // Add event attendee (direct method for compatibility)
  Future<bool> addEventAttendee(String eventId, String userId) async {
    try {
      await _firestoreService.addEventAttendee(eventId, userId);
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // RSVP to event
  Future<bool> rsvpEvent(String eventId, String userId, String eventName) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestoreService.addEventAttendee(eventId, userId);

      // Log analytics
      await _analyticsService.logEventRSVP(eventId, eventName);

      // Reload events
      await loadUpcomingEvents();

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Cancel RSVP
  Future<bool> cancelRSVP(String eventId, String userId) async {
    try {
      _isLoading = true;
      notifyListeners();

      await _firestoreService.removeEventAttendee(eventId, userId);

      // Reload events
      await loadUpcomingEvents();

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Create booking
  Future<bool> createBooking({
    required String userId,
    required String eventId,
    required String eventTitle,
    required DateTime eventDate,
    double? amount,
    String? stripePaymentIntentId,
  }) async {
    try {
      _isLoading = true;
      notifyListeners();

      BookingModel booking = BookingModel(
        id: '',
        userId: userId,
        eventId: eventId,
        eventTitle: eventTitle,
        eventDate: eventDate,
        amount: amount,
        stripePaymentIntentId: stripePaymentIntentId,
        status: BookingStatus.confirmed,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await _firestoreService.createBooking(booking);

      // Add user to event attendees
      await _firestoreService.addEventAttendee(eventId, userId);

      // Log purchase if paid
      if (amount != null && amount > 0) {
        await _analyticsService.logPurchase(
          transactionId: stripePaymentIntentId ?? '',
          value: amount,
          currency: 'AED',
          eventName: eventTitle,
        );
      }

      _isLoading = false;
      notifyListeners();

      return true;
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Listen to events stream
  Stream<List<EventModel>> getEventsStream({String? city}) {
    return _firestoreService.getEventsStream(city: city);
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
