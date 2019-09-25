//
//  BaseTitleController.swift
//  AFNetworking
//
//  Created by Ipkiss on 2019/9/25.
//

import Foundation

class BaseTitleController : UIViewController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationBarColor = UIColor(hexString: "0x02A2FD")
        self.navBar?.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: UIFont.Menlo(type: .Medium, size: 17)]
        
        
        let item = self.navigationItem.leftBarButtonItems?[0]
        let back = item?.customView as? UIButton
        back?.addTarget(self,
                        action: #selector(backToPrevious),
                        for: .touchUpInside)
    }
    
    @objc func backToPrevious(){
        self.popVC()
    }
    
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
