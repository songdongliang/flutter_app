/// @Date：2020/12/2 
/// @Author：songdongliang
/// Desc：
class Logger {
  final String name;
  bool mute = false;

  static final Map<String, Logger> _cache = Map();

  factory Logger(String name) {
    if (_cache.containsKey(name)) {
      return _cache[name];
    } else {
      var logger = Logger._internal(name);
      _cache[name] = logger;
      return logger;
    }
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }

  // 下边是工厂的调用方法与其他构造函数一样
  // var logger = Logger("UI")
  // logger.log("Button click")

}