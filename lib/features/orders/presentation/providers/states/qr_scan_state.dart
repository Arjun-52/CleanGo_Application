import 'package:equatable/equatable.dart';
import '../../../data/models/qr_scan_order_model.dart';
import '../../../data/models/media_evidence_model.dart';

abstract class QrScanState extends Equatable {
  const QrScanState();

  @override
  List<Object?> get props => [];
}

class QrScanInitial extends QrScanState {
  const QrScanInitial();
}

class QrScanLoading extends QrScanState {
  const QrScanLoading();
}

class QrScanSuccess extends QrScanState {
  final QrScanOrderModel orderDetails;

  const QrScanSuccess(this.orderDetails);

  @override
  List<Object?> get props => [orderDetails];
}

class QrScanError extends QrScanState {
  final String message;

  const QrScanError(this.message);

  @override
  List<Object?> get props => [message];
}

abstract class UploadEvidenceState extends Equatable {
  const UploadEvidenceState();

  @override
  List<Object?> get props => [];
}

class UploadEvidenceInitial extends UploadEvidenceState {
  const UploadEvidenceInitial();
}

class UploadEvidenceLoading extends UploadEvidenceState {
  const UploadEvidenceLoading();
}

class UploadEvidenceSuccess extends UploadEvidenceState {
  final MediaEvidenceModel evidence;

  const UploadEvidenceSuccess(this.evidence);

  @override
  List<Object?> get props => [evidence];
}

class UploadEvidenceError extends UploadEvidenceState {
  final String message;

  const UploadEvidenceError(this.message);

  @override
  List<Object?> get props => [message];
}
