//
//  BaseController.swift
//  IpkissWithCommon
//
//  Created by ld on 2019/9/2.
//

import Foundation
import UIKit

///没有状态栏
open class BaseController : UIViewController, UINavigationControllerDelegate{
    
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.edgesForExtendedLayout = []
        self.navigationController?.delegate = self
        self.navigationController?.navigationBar.barStyle = .default
    }
    
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    open func back(_ toViewControllerString : String){
        if navigationController != nil {
            let controllers = self.navigationController?.viewControllers
            var res = controllers?.filter({ (vc) -> Bool in
                if vc.isKind(of: swiftClassFromString(className: toViewControllerString)){
                    return true
                }else {
                    return false
                }
            })
            if (res?.count)! > 0 {
                self.navigationController?.popToViewController(res![0], animated: true)
            }
        }
    }
    
    open func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        if  let appName: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String? {
            // YourProject.className
            let classStringName = appName + "." + className
            return NSClassFromString(classStringName)
        }
        return nil;
    }
    
}

