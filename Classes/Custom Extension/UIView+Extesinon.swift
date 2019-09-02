//
//  UIView+Extesinon.swift
//  GICXmlTest
//
//  Created by ld on 2019/1/11.
//  Copyright © 2019 cm. All rights reserved.
//

import Foundation

extension UIView{
    
    func clearAll(){
        if(self.subviews.count > 0){
            self.subviews.forEach({$0.removeFromSuperview()})
        }
    }
    
    func setShadow(width:CGFloat,bColor:UIColor,
                   sColor:UIColor,offset:CGSize,opacity:Float,radius:CGFloat) {
        //设置视图边框宽度
        self.layer.borderWidth = width
        //设置边框颜色
        self.layer.borderColor = bColor.cgColor
        //设置边框圆角
        self.layer.cornerRadius = radius
        //设置阴影颜色
        self.layer.shadowColor = sColor.cgColor
        //设置透明度
        self.layer.shadowOpacity = opacity
        //设置阴影半径
        self.layer.shadowRadius = radius
        //设置阴影偏移量
        self.layer.shadowOffset = offset
    }
    //复制
    func duplicate(_ view: UIView?) -> UIView? {
        var tempArchive: Data? = nil
        if let view = view {
            tempArchive = NSKeyedArchiver.archivedData(withRootObject: view)
        }
        if let tempArchive = tempArchive {
            return NSKeyedUnarchiver.unarchiveObject(with: tempArchive) as? UIView
        }
        return nil
    }
    
    struct AssociatedKeys {
        static var kUIViewClick = "kUIClick"
    }
    
    var saveClickView : UIClick{
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.kUIViewClick) as? UIClick)!
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.kUIViewClick, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func setOnClickView(click : @escaping () -> Void) {
        self.isUserInteractionEnabled = true
        self.saveClickView = UIClick()
        self.saveClickView.click = click
        let tap = UITapGestureRecognizer(target: self, action: #selector(btnClick))
        tap.numberOfTapsRequired = 1
        self.addGestureRecognizer(tap)
    }
    
    @objc func btnClick(){
        self.saveClickView.click()
    }
    
}

class UIClick : Any{
    var click : () -> Void = {return}
}
