class ResLogin {
  String? nickname;
  String? userId;
  String? memberName;
  String? token;


  ResLogin(
      {this.nickname,
      this.userId,
      this.memberName,
      this.token,
       });
  factory ResLogin.fromJSON(Map<String, dynamic> json) {
    return ResLogin(
        nickname: json['nickname'],
        userId: json['userId'],
        memberName: json['memberName'],
        token: json['token']
    );

  }
}
