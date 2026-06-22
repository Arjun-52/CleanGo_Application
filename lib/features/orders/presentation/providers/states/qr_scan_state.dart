import 'package:equatable/equatable.dart';
import '../../../data/models/qr_scan_order_model.dart';

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
