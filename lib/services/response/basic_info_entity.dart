class BasicInfoEntity {
  int? expiredTime;
  String? appUrlAndroid;
  String? appUrlIos;
  String? serviceUrl;

  BasicInfoEntity({
    this.expiredTime,
    this.appUrlAndroid,
    this.appUrlIos,
    this.serviceUrl,
  });

  factory BasicInfoEntity.fromJson(Map<String, dynamic> json) {
    return BasicInfoEntity(
      expiredTime: json['expiredTime'] as int?,
      appUrlAndroid: json['appUrlAndroid'] as String?,
      appUrlIos: json['appUrlIos'] as String?,
        serviceUrl: json['serviceUrl'] as String?
    );
  }

  Map<String, dynamic> toJson() => {
    'expiredOrderTime': expiredTime,
    'appUrlAndroid': appUrlAndroid,
    'appUrlIos': appUrlIos,
    'serviceUrl': serviceUrl,
  };
}
