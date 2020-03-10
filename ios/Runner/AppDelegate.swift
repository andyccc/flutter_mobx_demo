import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    var flutterChannel: FlutterMethodChannel?
    var flutterMessageChannel: FlutterBasicMessageChannel?
    
    var timer: Timer?
    var count = 1
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        GeneratedPluginRegistrant.register(with: self)

        let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
        flutterChannel = FlutterMethodChannel(name: "samples.flutter.io", binaryMessenger: controller.binaryMessenger)
        flutterChannel?.setMethodCallHandler {
//            [weak self]
            (call: FlutterMethodCall, result: FlutterResult) -> Void in
            if "getBatterLevel" == call.method {
//                self?.
                receiveBatteryLevel(result: result)
                
                if let dic = call.arguments as? Dictionary<String, Any> {
                    print("收到了参数 ： \(dic)")
                }
                
            } else {
                result(FlutterMethodNotImplemented)
            }
        }
        
        /*
        if #available(iOS 10.0, *) {
            timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] (timer) in
                self?.count += 1
                self?.flutterChannel?.invokeMethod("sendtoFlutter", arguments: ["time": self?.count] , result: { result in
                    debugPrint("收到flutter 的返回 1： \(result)")
                    print("收到flutter 的返回 2： \(result)")
                })
            })
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.default)
        } else {
            // Fallback on earlier versions
        }
         */
        
        // eventchannel
        EventChannelDemo(messenger: controller.binaryMessenger)
        
        
        
        
        // messagechannel
        
        flutterMessageChannel = FlutterBasicMessageChannel(name: "samples.flutter.io/message2", binaryMessenger: controller.binaryMessenger)
        
        
        let messageChannel: FlutterBasicMessageChannel = FlutterBasicMessageChannel(name: "samples.flutter.io/message1", binaryMessenger: controller.binaryMessenger)
        messageChannel.setMessageHandler { [weak self] ( message, callback  ) in
            print("message : \(message)")
            callback("这是原生返回的数据。。。")
            
            DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                self?.flutterMessageChannel?.sendMessage("原生主动发来的数据", reply: { reply in
                    print("收到flutter的返回过来的数据 \(reply)")
                })
            }
        }
        
        
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    func sendMessageToFlutter() {
        
    }
    
    
}

private func receiveBatteryLevel(result: FlutterResult) {
    let device = UIDevice.current;
    device.isBatteryMonitoringEnabled = true
    if device.batteryState == .unknown {
        result(FlutterError(code: "UNABAILABLE", message: "电池信息不可用", details: nil))
    } else {
        result(Int(device.batteryLevel * 100))
    }
}
