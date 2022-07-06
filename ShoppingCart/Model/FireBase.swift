//
//  FireBase.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/7/8.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseCore

class FireBase {
    var data : TeaData! //test
    
    static let db : Firestore = {
        let db = Firestore.firestore()
        return db
    }()
    
    //MARK: - Firestore
    static func addData(data: CellViewModel, db: Firestore) {
        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .medium
//        dateFormatter.timeStyle = .long
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Taipei")
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.ss" //顯示到毫秒 方便做排序
        let date = dateFormatter.string(from: Date())
        db.collection("orders").addDocument(data: [
            "ID": "\(data.idName ?? "???")",
            "teaName": "\(data.teaName )",
            "count": "\(data.count ?? "1")",
            "price": "\(data.price)",
            "sugar": "\(data.sugar ?? "正常糖")",
            "ice" : "\(data.ice ?? "正常冰")",
            "image": "\(data.image )",
            "totalPrice": "\(data.totalPrice ?? data.price)",
            "date": date])
        
        // setData(data: myData, merge: Bool) 會覆蓋掉原有的資料
        //  merge 是指要不要只覆蓋有更動過的資料的部份，true 可以避免原有的資料整個被覆蓋或被刪除掉，作用跟 update 相同。
//        db.collection("orders").document("\(Date())").setData([
//            "ID": "\(data.idName ?? "???")",
//            "teaName": "\(data.teaName )",
//            "count": "\(data.count ?? "1")",
//            "price": "\(data.totalPrice ?? data.price)",
//            "sugar": "\(data.sugar ?? "正常糖")",
//            "ice" : "\(data.ice ?? "正常冰")",
//            "image": "\(data.image )",
//            "totalPrice": "\(data.totalPrice ?? data.price)"], merge: true)
    }
    func readData(){
        FireBase.db.collection("orders").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    print(document.data())
                }
            }
        }
    }
    // 刪除Document
    func deleteDocument() {
        // [START delete_document]
        FireBase.db.collection("orders").document("\(self.data.teaName )").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    // 刪除Collection
    func deleteCollection(collection: String) {
        FireBase.db.collection(collection).getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                return
            }
            
            for document in querySnapshot!.documents {
                print("Deleting \(document.documentID) => \(document.data())")
                document.reference.delete()
            }
        }
    }
    func updateData(){
        FireBase.db.collection("users").whereField("name", isEqualTo: "Max").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let document = querySnapshot.documents.first
                document?.reference.updateData(["size": "big"], completion: { (error) in
                })
            }
        }
    }

}
