
class Singleton {
  // 静态变量指向自身

  String? uuid;
  String? status;
  // List<ModelEntity>? items;

  // BaseModel? basemodel;

  // ModelResponse? userdata;


  Map<String, dynamic> data = {};

  String host = "";

  //构造方法
  Singleton();
  static final Singleton _instance = Singleton._();

  // 私有构造器
  Singleton._();
  //静态方法获得实例变量
  static Singleton getInstance() => _instance;
}
