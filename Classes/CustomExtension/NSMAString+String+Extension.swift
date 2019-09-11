//
//  NSString+String+Extension.swift
//  GICXmlTest
//
//  Created by ld on 2019/1/10.
//  Copyright © 2019 cm. All rights reserved.
//

import Foundation

extension NSMutableAttributedString{
    public func foreColor(color:UIColor)->NSMutableAttributedString{
        
        self.addAttributes([ NSAttributedString.Key.foregroundColor:color], range: self.allRange())
        
        return self
        
    }
    public func font(font:UIFont)->NSMutableAttributedString{
        
        self.addAttributes([NSAttributedString.Key.font:font], range: self.allRange())
        return self
        
    }
    
    public func lineStyle() -> NSMutableAttributedString{
        self.addAttributes([NSMutableAttributedString.Key.strikethroughStyle:NSUnderlineStyle.single.rawValue], range: self.allRange())
        return self
    }
    
    public func allRange()->NSRange{
        
        return NSMakeRange(0,self.length)
        
    }
}

extension String {
    //文本宽高
    public func li_widthForComment(font : UIFont , height: CGFloat = 15) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.width)
    }
    //文本宽高
    public func li_heightForComment(font : UIFont , width: CGFloat) -> CGFloat {
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(rect.height)
    }
    
}

extension String{
    public func toAttr()->NSMutableAttributedString{
        
        return NSMutableAttributedString(string: self)
    }
}

infix operator >>>: ATPrecedence
precedencegroup ATPrecedence{
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

public func >>> (attr1 : NSMutableAttributedString ,
                 attr2 : NSMutableAttributedString ) -> NSMutableAttributedString{
    attr1.append(attr2)
    return attr1
}
