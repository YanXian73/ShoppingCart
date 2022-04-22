//
//  GeneralFunc.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/4/21.
//

import UIKit

class GeneralFunc {
    
    static func showAlert(title: String, message: String?, cancelBtn: Bool? = nil, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "確定", style: .default, handler: nil)
        alert.addAction(action)
        vc.present(alert, animated: true, completion: nil)
        
    }

}// class
