import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import '../../domain/usecases/order_usecases.dart';
import 'states/qr_scan_state.dart';
import '../../data/models/media_evidence_model.dart';

class QrScanProvider with ChangeNotifier {
  final OrderUseCases _orderUseCases;

  QrScanState _state = const QrScanInitial();
  String? _lastScannedQr;

  UploadEvidenceState _uploadState = const UploadEvidenceInitial();
  UploadEvidenceState get uploadState => _uploadState;

  final List<MediaEvidenceModel> _uploadedEvidences = [];
  List<MediaEvidenceModel> get uploadedEvidences => _uploadedEvidences;

  double _imageUploadProgress = 0.0;
  double get imageUploadProgress => _imageUploadProgress;

  QrScanProvider(this._orderUseCases);

  QrScanState get state => _state;
  bool get isLoading => _state is QrScanLoading;
  String? get error => _state is QrScanError ? (_state as QrScanError).message : null;

  void reset() {
    _state = const QrScanInitial();
    _lastScannedQr = null;
    _uploadState = const UploadEvidenceInitial();
    _uploadedEvidences.clear();
    _imageUploadProgress = 0.0;
    notifyListeners();
  }

  Future<bool> scanQrCode(String qrCode) async {
    // Prevent duplicate scan requests or multiple API calls for the same scan while loading
    if (isLoading) {
      print("DEBUG: Scan request ignored. Scanner is currently loading.");
      return false;
    }

    _state = const QrScanLoading();
    notifyListeners();

    try {
      final orderDetails = await _orderUseCases.scanQrCode(qrCode);
      _state = QrScanSuccess(orderDetails);
      _lastScannedQr = qrCode;
      notifyListeners();
      return true;
    } catch (e) {
      String errorMessage = "Failed to scan QR code";
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data is Map) {
          final data = e.response?.data as Map;
          if (data['message'] != null) {
            errorMessage = data['message'].toString();
          }
        } else if (e.type == DioExceptionType.connectionTimeout || e.type == DioExceptionType.receiveTimeout) {
          errorMessage = "Network Timeout. Please try again.";
        } else {
          errorMessage = e.message ?? "Network failure";
        }
      } else {
        errorMessage = e.toString().replaceAll("Exception: ", "");
      }

      _state = QrScanError(errorMessage);
      notifyListeners();
      return false;
    }
  }

  /// Reload the last scanned QR (for refresh support)
  Future<void> refresh() async {
    if (_lastScannedQr != null) {
      await scanQrCode(_lastScannedQr!);
    }
  }

  Future<void> simulateImageSelection(String source) async {
    _uploadState = const UploadEvidenceLoading();
    _imageUploadProgress = 0.0;
    notifyListeners();

    for (int i = 1; i <= 5; i++) {
      await Future.delayed(const Duration(milliseconds: 150));
      _imageUploadProgress = i * 0.2;
      notifyListeners();
    }

    _uploadState = const UploadEvidenceInitial();
    notifyListeners();
  }

  Future<bool> uploadMediaEvidence({
    required String orderId,
    required String type,
    required String url,
    String? caption,
    bool hasDamage = false,
    bool isSigned = false,
  }) async {
    _uploadState = const UploadEvidenceLoading();
    notifyListeners();

    try {
      final evidence = await _orderUseCases.uploadMediaEvidence(
        orderId: orderId,
        type: type,
        url: url,
        caption: caption,
        hasDamage: hasDamage,
        isSigned: isSigned,
      );
      _uploadedEvidences.insert(0, evidence);
      _uploadState = UploadEvidenceSuccess(evidence);
      notifyListeners();
      return true;
    } catch (e) {
      String errorMessage = "Failed to upload evidence";
      if (e is DioException) {
        if (e.response?.data != null && e.response?.data is Map) {
          final data = e.response?.data as Map;
          if (data['message'] != null) {
            errorMessage = data['message'].toString();
          }
        } else {
          errorMessage = e.message ?? "Network failure";
        }
      } else {
        errorMessage = e.toString().replaceAll("Exception: ", "");
      }
      _uploadState = UploadEvidenceError(errorMessage);
      notifyListeners();
      return false;
    }
  }
}
