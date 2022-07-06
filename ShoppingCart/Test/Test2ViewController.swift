//
//  Test2ViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/10.
//

import UIKit

class Test2ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "d789", style: .plain, target: self, action: #selector(test))
        navigationItem.rightBarButtonItems = [editButtonItem]
        
    }
    @objc func test () {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "7878" {
            if let finishTVC = segue.destination as? Test2ViewController  {
                
            }
        }
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
