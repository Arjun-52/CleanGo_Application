import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentService {
  static const String walletKey = "wallet_balance";
  static const String transactionKey = "transactions";

  /// Get wallet balance
  Future<double> getWalletBalance() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(walletKey) ?? 0.0;
  }

  /// Add money to wallet
  Future<bool> addMoneyToWallet(double amount) async {
    final prefs = await SharedPreferences.getInstance();

    double balance = await getWalletBalance();
    balance += amount;

    await prefs.setDouble(walletKey, balance);

    await _addTransaction("Wallet Top-up", amount, "credit");

    return true;
  }

  /// Process payment
  Future<bool> processPayment({
    required double amount,
    required String paymentMethod,
    String? orderId,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    if (paymentMethod == "wallet") {
      double balance = await getWalletBalance();

      if (balance < amount) return false;

      balance -= amount;
      await prefs.setDouble(walletKey, balance);
    }

    await _addTransaction(orderId ?? "Order Payment", amount, "debit");

    return true;
  }

  /// Payment methods
  Future<List<Map<String, dynamic>>> getPaymentMethods() async {
    return [
      {'id': 'wallet', 'name': 'Wallet', 'icon': 'wallet'},
      {'id': 'upi', 'name': 'UPI', 'icon': 'account_balance'},
      {'id': 'card', 'name': 'Card', 'icon': 'credit_card'},
      {'id': 'cod', 'name': 'Cash on Delivery', 'icon': 'money'},
    ];
  }

  /// Transaction history
  Future<List<Map<String, dynamic>>> getTransactionHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString(transactionKey);

    if (data == null) return [];

    return List<Map<String, dynamic>>.from(jsonDecode(data));
  }

  /// Refund
  Future<bool> initiateRefund(String orderId) async {
    await addMoneyToWallet(100); // dummy refund amount
    return true;
  }

  /// Save transaction internally
  Future<void> _addTransaction(String title, double amount, String type) async {
    final prefs = await SharedPreferences.getInstance();

    List transactions = await getTransactionHistory();

    transactions.add({
      "title": title,
      "amount": amount,
      "type": type,
      "date": DateTime.now().toString(),
    });

    await prefs.setString(transactionKey, jsonEncode(transactions));
  }
}
