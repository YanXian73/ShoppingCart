//
//  TestViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/9/24.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
      //  view.backgroundColor = .blue
        imageView.image = UIImage(named: "青檸雷夢.jpg")
    //    imageView.layer.cornerRadius = 10
        self.imageView.layer.borderWidth = 10
        self.imageView.layer.borderColor = UIColor.blue.cgColor
        self.imageView.layer.cornerRadius = 10
        //self.imageView.layer.masksToBounds = true//cliptobounds
        
        self.imageView.layer.shadowColor = UIColor.darkGray.cgColor
        self.imageView.layer.shadowOpacity = 0.8
        self.imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
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
