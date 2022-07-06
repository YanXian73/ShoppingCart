//
//  SideMenuViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/9/24.
//

import UIKit
import SideMenu

class SideMenuViewController: UIViewController {
    
    var menu : SideMenuNavigationController?

    override func viewDidLoad() {
        super.viewDidLoad()
        let testVC = storyboard?.instantiateViewController(identifier: "testVC")
        menu = SideMenuNavigationController(rootViewController: testVC!)
        menu?.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
      //  SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.view)
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func dedTapMenu() {
        present(menu!, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
