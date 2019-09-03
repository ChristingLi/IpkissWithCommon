//
//  CAGradientLayerEx.swift
//  BeautifulFace
//
//  Created by ld on 2019/7/23.
//  Copyright © 2019 facing. All rights reserved.
//

import Foundation

extension CAGradientLayer {
    
    //获取彩虹渐变层
    public func gradientLayer(_ begin : UIColor,_ end : UIColor) -> CAGradientLayer {
        //定义渐变的颜色
        let gradientColors = [begin.cgColor,
                              end.cgColor]
        
        //定义每种颜色所在的位置
        let gradientLocations:[NSNumber] = [0.0,1.0]
        
        //创建CAGradientLayer对象并设置参数
        self.colors = gradientColors
        self.locations = gradientLocations
        
        //设置渲染的起始结束位置（横向渐变）
        self.startPoint = CGPoint(x: 0, y: 0)
        self.endPoint = CGPoint(x: 1, y: 0)
        
        return self
    }
    
}
