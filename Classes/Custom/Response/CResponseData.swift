//
//  CResponseData.swift
//  Pods
//
//  Created by ld on 2019/9/2.
//

import Foundation
import ObjectMapper

open class CResponseData : NSObject, NSCoding, Mappable{
    
    var status : String?
    var versionName : String?
    var isUpdate : String?
    var versionUrl : String?
    
    class func newInstance(map: Map) -> Mappable?{
        return CResponseData()
    }
    required public init?(map: Map){}
    private override init(){}
    
    public func mapping(map: Map)
    {
        status <- map["status"]
        versionName <- map["versionName"]
        isUpdate <- map["isUpdate"]
        versionUrl <- map["versionUrl"]
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        status = aDecoder.decodeObject(forKey: "status") as? String
        versionName = aDecoder.decodeObject(forKey: "versionName") as? String
        isUpdate = aDecoder.decodeObject(forKey: "isUpdate") as? String
        versionUrl = aDecoder.decodeObject(forKey: "versionUrl") as? String
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if versionName != nil{
            aCoder.encode(versionName, forKey: "versionName")
        }
        if isUpdate != nil{
            aCoder.encode(isUpdate, forKey: "isUpdate")
        }
        if versionUrl != nil{
            aCoder.encode(versionUrl, forKey: "versionUrl")
        }
    }
}

