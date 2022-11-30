
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
class GrabRefreshHomeEvent {
  String str;
  GrabRefreshHomeEvent(this.str);
}

class BindAddrRefreshDetailEvent {
  var model;
  BindAddrRefreshDetailEvent(this.model);
}

class GrabRefreshAddrListEvent {
  var model;
  GrabRefreshAddrListEvent(this.model);
}

class GrabRefreshBkListEvent {
  var model;
  GrabRefreshBkListEvent(this.model);
}
