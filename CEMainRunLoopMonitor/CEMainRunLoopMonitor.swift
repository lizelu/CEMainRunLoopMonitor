//
//  CEMainRunLoopMonitor.swift
//  CEMainRunLoopMonitor
//
//  Created by Mr.LuDashi on 2017/8/17.
//  Copyright © 2017年 ZeluLi. All rights reserved.
//

import Foundation

var count = 0
var waitAfterCurrentTime: TimeInterval = 0

class CEMainRunLoopMonitor {
    private static var instance: CEMainRunLoopMonitor!
    static func shareInstance() -> CEMainRunLoopMonitor{
        if CEMainRunLoopMonitor.instance == nil {
            CEMainRunLoopMonitor.instance = CEMainRunLoopMonitor()
        }
        
        return CEMainRunLoopMonitor.instance
    }
    
    var runLoopObserver: CFRunLoopObserver!
    
    func start() {
        if self.runLoopObserver != nil {
            return
        }
        
        var var_self = self
        var runLoopObserverContext = CFRunLoopObserverContext(version: 0, info: &var_self, retain: nil, release: nil, copyDescription: nil)
        self.runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault, CFRunLoopActivity.allActivities.rawValue, true, 0, { (runLoopObserver, runLoopActivity, info) in
            count = count + 1
            print("\(count) \(NSDate().timeIntervalSince1970)")
            CEMainRunLoopMonitor.displayActivity(runLoopActivity: runLoopActivity)
            
        }, &runLoopObserverContext)
        CFRunLoopAddObserver(CFRunLoopGetMain(), self.runLoopObserver, CFRunLoopMode.commonModes)
    }
    
    func stop() {
        if self.runLoopObserver == nil {
            return
        }
        
        CFRunLoopRemoveObserver(CFRunLoopGetMain(), self.runLoopObserver, CFRunLoopMode.commonModes)
        self.runLoopObserver = nil
    }
    
    static func displayActivity(runLoopActivity: CFRunLoopActivity) {
        switch runLoopActivity {
        case CFRunLoopActivity.entry:
            print("entry -- 进入")
            
        case CFRunLoopActivity.beforeSources:
            print("beforeSources -- 处理Sources之前")
            
        case CFRunLoopActivity.beforeTimers:
            print("beforeTimers -- 处理Timer之前")
            
        case CFRunLoopActivity.beforeWaiting:
            let timeInterval = NSDate().timeIntervalSince1970 - waitAfterCurrentTime
            print("beforeWaiting -- 即将等待 time = \(timeInterval)")
            
        case CFRunLoopActivity.afterWaiting:
            print("afterWaiting -- 等待之后")
            waitAfterCurrentTime = NSDate().timeIntervalSince1970
            
        case CFRunLoopActivity.exit:
            print("exit -- 退出")
            
        default:
            print(runLoopActivity)
        }
        
        print()
    }
    

}
