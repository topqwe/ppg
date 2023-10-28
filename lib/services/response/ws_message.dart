class WsMessage {
  String? msg;
  int? notifyType;
  String? orderId;
  String? pushMemberId;
  int? status;

  WsMessage({
    this.msg,
    this.notifyType,
    this.orderId,
    this.pushMemberId,
    this.status,
  });

  factory WsMessage.fromJson(Map<String, dynamic> json) => WsMessage(
        msg: json['msg'] as String?,
        notifyType: json['notifyType'] as int?,
        orderId: json['orderId'] as String?,
        pushMemberId: json['pushMemberId'] as String?,
        status: json['status'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'msg': msg,
        'notifyType': notifyType,
        'orderId': orderId,
        'pushMemberId': pushMemberId,
        'status': status,
      };
}
