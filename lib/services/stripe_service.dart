import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:cloud_functions/cloud_functions.dart';

class StripeService {
  static final StripeService _instance = StripeService._internal();
  factory StripeService() => _instance;
  StripeService._internal();

  final FirebaseFunctions _functions = FirebaseFunctions.instance;

  bool _isInitialized = false;

  /// Initialize Stripe with publishable key
  /// Call this in main.dart before runApp()
  Future<void> initialize(String publishableKey) async {
    if (_isInitialized) return;

    try {
      Stripe.publishableKey = publishableKey;
      await Stripe.instance.applySettings();
      _isInitialized = true;
      debugPrint('Stripe initialized successfully');
    } catch (e) {
      debugPrint('Failed to initialize Stripe: $e');
      rethrow;
    }
  }

  /// Create a payment intent via Cloud Function
  Future<Map<String, dynamic>> createPaymentIntent({
    required double amount,
    required String currency,
    required String eventId,
    required String userId,
    required String eventName,
  }) async {
    try {
      // Call Cloud Function to create payment intent
      final result = await _functions.httpsCallable('createPaymentIntent').call({
        'amount': (amount * 100).toInt(), // Convert to cents
        'currency': currency.toLowerCase(),
        'eventId': eventId,
        'userId': userId,
        'eventName': eventName,
      });

      return {
        'clientSecret': result.data['clientSecret'],
        'paymentIntentId': result.data['paymentIntentId'],
      };
    } catch (e) {
      debugPrint('Error creating payment intent: $e');
      throw Exception('Failed to create payment intent: $e');
    }
  }

  /// Present payment sheet and process payment
  Future<String?> processPayment({
    required double amount,
    required String currency,
    required String eventId,
    required String userId,
    required String eventName,
  }) async {
    try {
      // 1. Create payment intent
      final paymentIntent = await createPaymentIntent(
        amount: amount,
        currency: currency,
        eventId: eventId,
        userId: userId,
        eventName: eventName,
      );

      // 2. Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntent['clientSecret'],
          merchantDisplayName: 'MySheTribe',
          customerId: userId,
          style: ThemeMode.light,
          appearance: PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Color(0xFFD5A472), // Gold color from your theme
              background: Color(0xFFFFFFFF),
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: Color(0xFF2C2C2C), // Dark button
                  text: Color(0xFFFFFFFF),
                ),
              ),
            ),
          ),
        ),
      );

      // 3. Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // 4. Payment successful, return payment intent ID
      debugPrint('Payment successful: ${paymentIntent['paymentIntentId']}');
      return paymentIntent['paymentIntentId'];

    } on StripeException catch (e) {
      debugPrint('Stripe error: ${e.error.localizedMessage}');

      // User cancelled or error occurred
      if (e.error.code == FailureCode.Canceled) {
        throw Exception('Payment cancelled');
      } else {
        throw Exception('Payment failed: ${e.error.localizedMessage}');
      }
    } catch (e) {
      debugPrint('Payment error: $e');
      rethrow;
    }
  }

  /// Confirm payment status via Cloud Function
  Future<bool> confirmPaymentStatus(String paymentIntentId) async {
    try {
      final result = await _functions.httpsCallable('confirmPaymentStatus').call({
        'paymentIntentId': paymentIntentId,
      });

      return result.data['status'] == 'succeeded';
    } catch (e) {
      debugPrint('Error confirming payment status: $e');
      return false;
    }
  }

  /// Process refund via Cloud Function
  Future<bool> refundPayment({
    required String paymentIntentId,
    required double amount,
    String? reason,
  }) async {
    try {
      final result = await _functions.httpsCallable('refundPayment').call({
        'paymentIntentId': paymentIntentId,
        'amount': (amount * 100).toInt(), // Convert to cents
        'reason': reason ?? 'requested_by_customer',
      });

      return result.data['success'] == true;
    } catch (e) {
      debugPrint('Error processing refund: $e');
      return false;
    }
  }
}
