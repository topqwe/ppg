import 'package:event_bus/event_bus.dart';

class EventBusNew {
  static final EventBus eventBus = EventBus();
}


class RouteChangedEvent {
  final List? arr;
  final int? index;
  RouteChangedEvent({this.arr,this.index});
}