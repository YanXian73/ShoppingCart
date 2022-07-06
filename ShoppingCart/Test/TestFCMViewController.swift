//
//  TestViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/4/12.
//

import UIKit

class TestFCMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "d789", style: .plain, target: self, action: #selector(test))
        navigationItem.rightBarButtonItems = [editButtonItem,editButtonItem]
        let button = UIButton(type: .roundedRect)
              button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
              button.setTitle("Test Crash", for: [])
              button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
              view.addSubview(button)
          }

          @IBAction func crashButtonTapped(_ sender: AnyObject) {
              let numbers = [0]
              let _ = numbers[1]
          }
        
    @objc func test () {
        
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
