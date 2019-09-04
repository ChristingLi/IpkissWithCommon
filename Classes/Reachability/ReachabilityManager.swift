//
//  ReachabilityManager.swift
//  Pods
//
//  Created by ld on 2019/9/2.
//

import Foundation
import AFNetworking

open class ReachabilityManager : NSObject {
    
    fileprivate let manager = AFNetworkReachabilityManager.shared()
    
    fileprivate var isNeedAfterRequset = false
    
    
    public init(_ callback:@escaping() -> ()) {
        super.init()
        manager.setReachabilityStatusChange { (status) in
            switch status {
            case .notReachable,.unknown:
                self.isNeedAfterRequset =  true
                break
            case .reachableViaWiFi:
                self.isNeedAfterRequset =  true
                callback()
                break
            case .reachableViaWWAN:
                if self.isNeedAfterRequset {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        callback()
                        self.isNeedAfterRequset = false
                    })
                }else{
                    callback()
                }
                break
            default:
                break
            }
        }
    }
    
    
    public func start(){
        manager.startMonitoring()
    }
    
}

