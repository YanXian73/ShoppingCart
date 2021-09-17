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
    var data : TeaData!
    var db : Firestore!
    
    //MARK:Firestore
    func addData() {
        db.collection("orders").document("\(self.data.teaName ?? "")").setData([
                                                                                "name": "\(self.data.teaName ?? "")",
                                                                                "count": "\(self.data.count ?? "")",
                                                                                "price": "\(self.data.price ?? "")",
                                                                                "sugar": "\(self.data.sugar ?? "")",
                                                                                "ice" : "\(self.data.ice ?? "")"])
        
    }
    func readData(){
   
        db.collection("orders").getDocuments { (querySnapshot, error) in
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
        db.collection("orders").document("\(self.data.teaName ?? "")").delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }

    // 刪除Collection
    func deleteCollection(collection: String) {
        db.collection(collection).getDocuments() { (querySnapshot, err) in
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
        db.collection("users").whereField("name", isEqualTo: "Max").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let document = querySnapshot.documents.first
                document?.reference.updateData(["size": "big"], completion: { (error) in
                })
            }
        }
    }

}
