import 'package:flutter/foundation.dart';
import '../services/payment_service.dart';

class WalletProvider with ChangeNotifier {
  final PaymentService _paymentService = PaymentService();
  
  double _balance = 0.0;
  List<Map<String, dynamic>> _transactions = [];
  bool _isLoading = false;
  String? _error;

  double get balance => _balance;
  List<Map<String, dynamic>> get transactions => _transactions;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadWalletData() async {
    _isLoading = true;
    notifyListeners();

    try {
      _balance = await _paymentService.getWalletBalance();
      _transactions = await _paymentService.getTransactionHistory();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> addMoney(double amount) async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await _paymentService.addMoneyToWallet(amount);
      if (result) {
        _balance += amount;
      }
      _isLoading = false;
      notifyListeners();
      return result;
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
