class ConfigEnv {
  int env;
  String appBaseUrl;
  final String bizWsUrl;
  final String onlineWsUrl;
  String localversion;
  final String domainListPath;
  final bool autoChangeDomain;

  ConfigEnv({
    this.env = 1,
    this.appBaseUrl = "http://apifront.hgtmj",
    this.bizWsUrl = "wss://biz",
    this.onlineWsUrl = "wss://online/",
    this.localversion = "1.0.0",
    this.domainListPath = "http://api.hgtmj.com:8000/originfrontbase.json",
    this.autoChangeDomain = true,
  });

  factory ConfigEnv.dev() => ConfigEnv(env : 0,
        appBaseUrl: "http://apifront.hgtmj.com",
        bizWsUrl: "wss://biz",
        onlineWsUrl: "wss://online/",
        autoChangeDomain: true,//+82
      );
}
