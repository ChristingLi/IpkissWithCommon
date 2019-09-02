//
//  UITableView+Extension.swift
//  Fate
//
//  Created by ld on 2019/5/21.
//  Copyright © 2019 fate. All rights reserved.
//

import Foundation

extension UITableView {
    
    func setAndLayoutTableHeaderView(header: UIView) {
        
        self.tableHeaderView = header
        //Tip:这里要先计算子视图的高度后，再去更新tableHeaderView的布局
        for view in header.subviews {
            guard let label = view as? UILabel, label.numberOfLines == 0 else { continue }
            //设置子视图的preferredMaxLayoutWidth
            label.preferredMaxLayoutWidth = label.frame.width
        }
        //更新tableHeaderView的布局
        header.setNeedsLayout()
        header.layoutIfNeeded()
        var frame = header.frame
        let size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        frame.size = size
        
        header.frame = frame
        self.tableHeaderView = header
    }
    
    func setAndLayoutTableFooterView(footer: UIView) {
        self.tableFooterView = footer
        //Tip:这里要先计算子视图的高度后，再去更新tableHeaderView的布局
        //作用域为最上级
        for view in footer.subviews {
            guard let label = view as? UILabel, label.numberOfLines == 0 else {
                print("setAndLayoutTableFooterView continue")
                continue
            }
            //设置子视图的preferredMaxLayoutWidth
            label.preferredMaxLayoutWidth = label.frame.width
            print("setAndLayoutTableFooterView \(label.preferredMaxLayoutWidth)")
        }
        //更新tableHeaderView的布局
        footer.setNeedsLayout()
        footer.layoutIfNeeded()
        var frame = footer.frame
        let size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        frame.size = size
        footer.frame = frame
        self.tableFooterView = footer
        
    }
    
}

