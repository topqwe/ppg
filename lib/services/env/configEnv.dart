class ConfigEnv {
  String appBaseUrl;
  final String bizWsUrl;
  final String onlineWsUrl;
  String localversion;
  final String domainListPath;
  final bool autoChangeDomain;
  final String businessID;

  ConfigEnv({
    this.appBaseUrl = "http://apifront.hgtmj",
    this.bizWsUrl = "wss://biz",
    this.onlineWsUrl = "wss://online/",
    this.localversion = "1.0.0",
    this.domainListPath = "http://api.hgtmj.com:8000/originfrontbase.json",
    this.autoChangeDomain = true,
    this.businessID = "123456",
  });

  factory ConfigEnv.dev() => ConfigEnv(
        appBaseUrl: "http://apifront.hgtmj.com",
        bizWsUrl: "wss://biz",
        onlineWsUrl: "wss://online/",
        autoChangeDomain: false,//+82
      );
}
