import 'package:equatable/equatable.dart';
import '../../../data/models/order_timeline_model.dart';

abstract class OrderTimelineState extends Equatable {
  const OrderTimelineState();

  @override
  List<Object?> get props => [];
}

class OrderTimelineInitial extends OrderTimelineState {
  const OrderTimelineInitial();
}

class OrderTimelineLoading extends OrderTimelineState {
  const OrderTimelineLoading();
}

class OrderTimelineSuccess extends OrderTimelineState {
  final OrderTimelineModel orderTimeline;

  const OrderTimelineSuccess(this.orderTimeline);

  @override
  List<Object?> get props => [orderTimeline];
}

class OrderTimelineError extends OrderTimelineState {
  final String message;

  const OrderTimelineError(this.message);

  @override
  List<Object?> get props => [message];
}
