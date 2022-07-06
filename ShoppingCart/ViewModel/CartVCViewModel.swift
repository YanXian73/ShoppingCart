//
//  FinishVCViewModel.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/17.
//

import UIKit

class CartVCViewModel {
    
    // Models
    private(set) var cartListCell = [CellViewModel]()
    
    var totalCount: String? {
        get{
            var total = 0
            for cell in cartListCell {
                let count = Int(cell.count!)
                if let count = count {
                    total += count
                }
            }
           return "\(total)"
        }
    }
    var totalPrice: String? {
        get{
            var total = 0
            for cell in cartListCell {
                let count = Int(cell.count!)
                let price = Int(cell.price)
                if let count = count, let price = price {
                    total += count * price
                }
            }
           return "\(total)"
        }
    }

    var onReadDataDone: (() -> Void)?
    var onDeleteDateDone: ((IndexPath) -> Void)?
    
    func readData() {
        FireBase.db.collection("orders").order(by: "date", descending: true).getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    let cell = CellViewModel(name: "", price: "", detail: "", image: "")
                    cell.documentID = document.documentID
                    cell.idName = document.data()["ID"] as? String
                    cell.teaName = document.data()["teaName"] as! String
                    cell.price = document.data()["price"] as! String
                    cell.count = document.data()["count"] as? String
                    cell.ice = document.data()["ice"] as? String
                    cell.sugar = document.data()["sugar"] as? String
                    cell.image = document.data()["image"] as! String
                    self.cartListCell.append(cell)
                    
                }
                self.onReadDataDone?()
            }
        }
    }
    func deleteData(indexPath: IndexPath) {
        FireBase.db.collection("orders").document(cartListCell[indexPath.row].documentID!).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
                self.cartListCell.remove(at: indexPath.row)
                self.onDeleteDateDone?(indexPath)
            }
            
        }
    }
} // class
