// 订阅者回调签名

typedef void EventCallback(params);

class EventBus {
  // 私有构造函数
  EventBus._internal();

  // 保存单例
  static EventBus _singleton = EventBus._internal();

  // 工厂构造函数
  factory EventBus() => _singleton;

  // 保存时间订阅者队列，key：时间名称（id），value：对应时间点订阅者队列
  var _emap = Map<Object, List<EventCallback>>();

  // 添加订阅者
  void on(eventName, EventCallback f) {
    if (eventName == null || f == null) return;
    _emap[eventName] ??= List<EventCallback>();
    _emap[eventName].add(f);
  }

  // 移除订阅者
  void off(eventName, [EventCallback f]) {
    var list = _emap[eventName];
    if (eventName == null || list == null) return;
    if (f == null) {
      _emap[eventName] = null;
    } else {
      list.remove(f);
    }
  }

// 触发事件，时间触发后改时间所有订阅者会被调用
  void emit(eventName, [params]) {
    var list = _emap[eventName];
    if (list == null) return;
    int len = list.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      list[i](params);
    }
  }
}

// 定义一个top-level（全局）变量。页面引入该文件后可以直接使用bus
var bus = EventBus();
