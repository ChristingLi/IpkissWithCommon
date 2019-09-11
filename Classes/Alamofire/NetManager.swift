//
//  NetworkManager.swift
//  Pods
//
//  Created by ld on 2019/9/2.
//

import Foundation
import Alamofire
import ObjectMapper


open class NetManager  {
    
    public init() {
        
    }
    /*
     * 目前这个方法只提供了Get 和 固定 iosVersionr如需拓展请自行Ex
     * url : String -> 请求地址
     * vesion : Int -> iosVersion
     * callback : Bool -> true : B false : A
     */
    open func thingsGet(_ url : String ,
                        _ version : Int,
                        callback : @escaping(_ status : Bool) -> Void){
        Alamofire.request(url,
                          method: .get,
                          parameters: [ "iosVersion" : version ],
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) in
                if let data = response.data ,
                    let utf8Text = String(data: data, encoding: .utf8) ,
                    let res = Mapper<CResponseable>().map(JSONString: utf8Text){
                    print("Response  \(utf8Text)")
                    if res.code == 0 {
                        if res.data?.status == "YES"{
                            callback(true)
                            if res.data?.isUpdate == "YES"{
                                self.foundNew(res.data!.versionName!)
                            }
                        }else{
                            callback(false)
                        }
                    }
                }
        }
    }
    
    /*
     * 目前这个方法只提供了Get 和 固定 iosVersionr如需拓展请自行Ex
     * url : String -> 请求地址
     * vesion : Int -> iosVersion
     * callback : (status & isGads ) 
     */
    open func thingsAdsGet(_ url : String ,
                           _ version : Int,
                           callback : @escaping(_ status : Bool,
                                                _ isgAds : Bool) -> Void){
        Alamofire.request(url,
                          method: .get,
                          parameters: [ "iosVersion" : version ],
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) in
                if let data = response.data ,
                    let utf8Text = String(data: data, encoding: .utf8) ,
                    let res = Mapper<CResponseable>().map(JSONString: utf8Text){
                    print("Response  \(utf8Text)")
                    if res.code == 0 {
                        if res.data?.status == "YES"{
                            if res.data?.versionUrl == "GOOGLE"{
                                callback(true,true)
                            }else{
                                callback(true,false)
                            }
                            if res.data?.isUpdate == "YES"{
                                self.foundNew(res.data!.versionName!)
                            }
                        }else{
                            callback(false,false)
                        }
                    }
                }
        }
    }
    
    func foundNew(_ url : String){
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "提示",
                                               message: "发现新版本",
                                               preferredStyle: .alert)
            let sure = UIAlertAction(title: "确定", style: .default, handler: { (action) in
                UIApplication.shared.openURL(URL(string: "\(url)")!)
            })
            alert.addAction(sure)
            if let window = UIApplication.shared.delegate?.window {
                window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    
}
