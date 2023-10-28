import 'dart:convert';

import '../cache/storage.dart';

class ResInfoUser {
  String? memberId;
  String? memberName;
  int? memberType;
  int? memberCate;
  String? nickname;
  String? realName;
  String? payAddress;
  String? amount;
  String? amountAble;
  String? amountSell;
  String? amountBuy;
  String? amountTrade;
  String? amountBusIn;
  String? amountBusOut;
  String? amountFee;
  int? sex;
  dynamic avatar;
  String? qq;
  String? remark;
  bool? ismw;
  String? loginName;
  // 自定义属性 外部浏览器
  String? isOutBrowser;

  ResInfoUser({
    this.memberId,
    this.memberName,
    this.memberType,
    this.memberCate,
    this.nickname,
    this.realName,
    this.payAddress,
    this.amount,
    this.amountAble,
    this.amountSell,
    this.amountBuy,
    this.amountTrade,
    this.amountBusIn,
    this.amountBusOut,
    this.amountFee,
    this.sex,
    this.avatar,
    this.qq,
    this.remark,
    this.ismw,
    this.isOutBrowser,
    this.loginName,
  });

  factory ResInfoUser.fromJson(Map<String, dynamic> json) => ResInfoUser(
        memberId: json['memberId'] as String?,
        memberName: json['memberName'] as String?,
        memberType: json['memberType'] as int?,
        memberCate: json['memberCate'] as int?,
        nickname: json['nickname'] as String?,
        realName: json['realName'] as String?,
        payAddress: json['payAddress'] as String?,
        amount: json['amount'] as String?,
        amountAble: json['amountAble'] as String?,
        amountSell: json['amountSell'] as String?,
        amountBuy: json['amountBuy'] as String?,
        amountTrade: json['amountTrade'] as String?,
        amountBusIn: json['amountBusIn'] as String?,
        amountBusOut: json['amountBusOut'] as String?,
        amountFee: json['amountFee'] as String?,
        sex: json['sex'] as int?,
        avatar: json['avatar'] as dynamic,

        qq: json['qq'] as String?,
        remark: json['remark'] as String?,
    ismw: json['ismw'] as bool?,
        isOutBrowser: json["isOutBrowser"] as String?,
        loginName: json["loginName"] as String?,
      );

  Map<String, dynamic> toJson() => {
        'memberId': memberId,
        'memberName': memberName,
        'memberType': memberType,
        'memberCate': memberCate,
        'nickname': nickname,
        'realName': realName,
        'payAddress': payAddress,
        'amount': amount,
        'amountAble': amountAble,
        'amountSell': amountSell,
        'amountBuy': amountBuy,
        'amountTrade': amountTrade,
        'amountBusIn': amountBusIn,
        'amountBusOut': amountBusOut,
        'amountFee': amountFee,
        'sex': sex,
        'avatar': avatar,

        'qq': qq,
        'remark': remark,
        'ismw': ismw,
        'isOutBrowser': isOutBrowser,
        'loginName': loginName,
      };



  String getStatus() {
    if (1 == 1) {
      return "";
    } else if (2 == 2) {
      return "";
    } else if (3 == 3) {
      return "";
    }
    return "unknown";
  }



}
