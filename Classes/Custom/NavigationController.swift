//
//  NavigationController.swift
//  IpkissWithCommon
//
//  Created by ld on 2019/9/2.
//

import Foundation
import UIKit

open class NavigationController : UINavigationController {
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = self.viewControllers.count >= 1
        super.pushViewController(viewController, animated: true)
        
    }
}

