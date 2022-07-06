//
//  OrderCellViewModel.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/16.
//

import Foundation

class OrderCellViewModel {
    //MARK: - 變數
    var name: String
    var price: String
    var detail: String
    var image: String
    var sugar : String?
    var ice : String?
    var documentID: String?
    
    var count: String? {
        didSet{
            if let count = count, let num = Int(count), num>0, num<=100 {
                getTotalPrice(count: num)
            }else {
                count = "1"
                getTotalPrice(count: 1)
            }
        }
    }
    init(name: String, price: String, detail: String, image: String){
        self.name = name
        self.price = price
        self.detail = detail
        self.image = image
    }
    var stepper: String?
    
    var onCountIsDone: ((String) -> Void)?
   
    //MARK: - func
    private func getTotalPrice(count: Int) {
        let totalPrice = "$\(count * Int(price)!)"
        onCountIsDone?(totalPrice)
    }
    
}//class
