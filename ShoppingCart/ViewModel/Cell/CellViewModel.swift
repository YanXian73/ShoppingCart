//
//  MenuCellViewModel.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/14.
//

import UIKit

class CellViewModel {
    
    var teaName: String
    var price: String
    var detail: String
    var image: String
    var sugar : String?
    var ice : String?
    var idName: String?
    var totalPrice: String?
    var documentID: String?

    init(name: String, price: String, detail: String, image: String){
        self.teaName = name
        self.price = price
        self.detail = detail
        self.image = image
    }
    var count: String? {
        didSet{
            if let count = count, let num = Int(count), num>0, num<=100 {
                self.count = count
                getTotalPrice(count: num)
            }else {
                count = "1"
                getTotalPrice(count: 1)
            }
        }
    }
    
    var onCountIsDone: ((String) -> Void)?
   
    //MARK: - func
    private func getTotalPrice(count: Int) {
        totalPrice = "\(count * Int(price)!)"
        onCountIsDone?(totalPrice!)
    }
    
    
    
    
}//class


