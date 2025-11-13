import 'package:flutter/foundation.dart';
import 'package:myshetribe/models/partnership_offer_model.dart';
import 'package:myshetribe/services/firestore_service.dart';
import 'package:myshetribe/services/analytics_service.dart';

class PartnershipProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final AnalyticsService _analyticsService = AnalyticsService();

  List<PartnershipOfferModel> _offers = [];
  List<PartnershipOfferModel> _featuredOffers = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<PartnershipOfferModel> get offers => _offers;
  List<PartnershipOfferModel> get featuredOffers => _featuredOffers;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load all active offers
  Future<void> loadOffers({String? city}) async {
    try {
      _isLoading = true;
      notifyListeners();

      _offers = await _firestoreService.getActivePartnershipOffers(city: city);

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Load featured offers
  Future<void> loadFeaturedOffers() async {
    try {
      _isLoading = true;
      notifyListeners();

      _featuredOffers = await _firestoreService.getFeaturedPartnershipOffers();

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Get offer by ID
  Future<PartnershipOfferModel?> getOffer(String id) async {
    try {
      return await _firestoreService.getPartnershipOffer(id);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return null;
    }
  }

  // View offer (track analytics)
  Future<void> viewOffer(String offerId, String offerName) async {
    try {
      await _analyticsService.logPartnershipOfferView(offerId, offerName);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Redeem offer
  Future<bool> redeemOffer(String offerId, String offerName) async {
    try {
      await _firestoreService.incrementOfferUsage(offerId);
      await _analyticsService.logPartnershipOfferRedeem(offerId, offerName);
      return true;
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }

  // Listen to offers stream
  Stream<List<PartnershipOfferModel>> getOffersStream() {
    return _firestoreService.getPartnershipOffersStream();
  }

  // Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
