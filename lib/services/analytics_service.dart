import 'package:firebase_analytics/firebase_analytics.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  // Set user ID
  Future<void> setUserId(String userId) async {
    try {
      await _analytics.setUserId(id: userId);
    } catch (e) {
      print('Failed to set user ID: $e');
    }
  }

  // Set user properties
  Future<void> setUserProperty(String name, String value) async {
    try {
      await _analytics.setUserProperty(name: name, value: value);
    } catch (e) {
      print('Failed to set user property: $e');
    }
  }

  // Log screen view
  Future<void> logScreenView(String screenName) async {
    try {
      await _analytics.logScreenView(
        screenName: screenName,
      );
    } catch (e) {
      print('Failed to log screen view: $e');
    }
  }

  // Log user sign up
  Future<void> logSignUp(String method) async {
    try {
      await _analytics.logSignUp(signUpMethod: method);
    } catch (e) {
      print('Failed to log sign up: $e');
    }
  }

  // Log user login
  Future<void> logLogin(String method) async {
    try {
      await _analytics.logLogin(loginMethod: method);
    } catch (e) {
      print('Failed to log login: $e');
    }
  }

  // Log event RSVP
  Future<void> logEventRSVP(String eventId, String eventName) async {
    try {
      await _analytics.logEvent(
        name: 'event_rsvp',
        parameters: <String, Object>{
          'event_id': eventId,
          'event_name': eventName,
        },
      );
    } catch (e) {
      print('Failed to log event RSVP: $e');
    }
  }

  // Log tribe join
  Future<void> logTribeJoin(String tribeId, String tribeName) async {
    try {
      await _analytics.logEvent(
        name: 'tribe_join',
        parameters: <String, Object>{
          'tribe_id': tribeId,
          'tribe_name': tribeName,
        },
      );
    } catch (e) {
      print('Failed to log tribe join: $e');
    }
  }

  // Log partnership offer view
  Future<void> logPartnershipOfferView(String offerId, String offerName) async {
    try {
      await _analytics.logEvent(
        name: 'partnership_view',
        parameters: <String, Object>{
          'offer_id': offerId,
          'offer_name': offerName,
        },
      );
    } catch (e) {
      print('Failed to log partnership offer view: $e');
    }
  }

  // Log partnership offer redeem
  Future<void> logPartnershipOfferRedeem(String offerId, String offerName) async {
    try {
      await _analytics.logEvent(
        name: 'partnership_redeem',
        parameters: <String, Object>{
          'offer_id': offerId,
          'offer_name': offerName,
        },
      );
    } catch (e) {
      print('Failed to log partnership offer redeem: $e');
    }
  }

  // Log profile update
  Future<void> logProfileUpdate() async {
    try {
      await _analytics.logEvent(name: 'profile_update');
    } catch (e) {
      print('Failed to log profile update: $e');
    }
  }

  // Log search
  Future<void> logSearch(String searchTerm, String searchType) async {
    try {
      await _analytics.logSearch(
        searchTerm: searchTerm,
        parameters: <String, Object>{
          'search_type': searchType,
        },
      );
    } catch (e) {
      print('Failed to log search: $e');
    }
  }

  // Log share
  Future<void> logShare(String contentType, String contentId) async {
    try {
      await _analytics.logShare(
        contentType: contentType,
        itemId: contentId,
        method: 'app_share',
      );
    } catch (e) {
      print('Failed to log share: $e');
    }
  }

  // Log custom event
  Future<void> logCustomEvent(String eventName, Map<String, Object> parameters) async {
    try {
      await _analytics.logEvent(
        name: eventName,
        parameters: parameters,
      );
    } catch (e) {
      print('Failed to log custom event: $e');
    }
  }

  // Log purchase (for Stripe payments)
  Future<void> logPurchase({
    required String transactionId,
    required double value,
    required String currency,
    String? eventName,
  }) async {
    try {
      await _analytics.logPurchase(
        currency: currency,
        value: value,
        transactionId: transactionId,
        parameters: <String, Object>{
          if (eventName != null) 'event_name': eventName,
        },
      );
    } catch (e) {
      print('Failed to log purchase: $e');
    }
  }
}
