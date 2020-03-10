//
//  EventChannelDemo.swift
//  EventChannelDemo
//
//  Created by yans on 2021/8/20.
//

import UIKit
import Flutter

class EventChannelDemo: NSObject {
    var channel: FlutterEventChannel?
    var count = 0
    var events: FlutterEventSink?
    
    public override init() {
        super.init()
    }
    
    
}

extension EventChannelDemo: FlutterStreamHandler {

    convenience init(messenger: FlutterBinaryMessenger) {
        self.init()
        
        channel = FlutterEventChannel(name: "samples.flutter.event", binaryMessenger: messenger)
        channel?.setStreamHandler(self)
        
    }
    
    
    func startTimer(){
        //        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] (timer) in
        //
        //        }
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.tickDown), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: RunLoop.Mode.default)
    }
    
    @objc
    func tickDown() {
        count += 1
        let args = ["count" : count]
        if events != nil {
            events!(args)
        }
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        self.events = events
        return nil
    }
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        self.events = nil
        return nil
    }
    
}
