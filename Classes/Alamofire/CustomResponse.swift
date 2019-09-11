//
//  CustomResponse.swift
//  Pods
//
//  Created by ld on 2019/9/2.
//

import Foundation
import ObjectMapper

open class CResponseable : NSObject, NSCoding, Mappable{
    
    var code : Int?
    var data : CResponseData?
    var msg : String?
    
    
    open class func newInstance(map: Map) -> Mappable?{
        return CResponseable()
    }
    required public init?(map: Map){}
    
    public override init(){}
    
    open func mapping(map: Map)
    {
        code <- map["code"]
        data <- map["data"]
        msg <- map["msg"]
        
    }
    
    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required public init(coder aDecoder: NSCoder)
    {
        code = aDecoder.decodeObject(forKey: "code") as? Int
        data = aDecoder.decodeObject(forKey: "data") as? CResponseData
        msg = aDecoder.decodeObject(forKey: "msg") as? String
        
    }
    
    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc public func encode(with aCoder: NSCoder)
    {
        if code != nil{
            aCoder.encode(code, forKey: "code")
        }
        if data != nil{
            aCoder.encode(data, forKey: "data")
        }
        if msg != nil{
            aCoder.encode(msg, forKey: "msg")
        }
        
    }
    
}
