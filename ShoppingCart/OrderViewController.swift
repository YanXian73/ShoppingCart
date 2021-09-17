//
//  OrderViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/7/5.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore

//protocol OrderViewControllerDeleage: AnyObject {
//    func updateTotalPrice(cell:MyCell)
//}
class OrderViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var db: Firestore!
  //  weak var deleage : OrderViewControllerDeleage?
    var currentData : TeaData!
 //   var finishData = TeaData()
    var myCell : MyCell!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        
        self.tableView.rowHeight = self.tableView.frame.size.height/1
        tableView.dataSource = self
        tableView.delegate = self
  //      let image = UIImage(named: "teaimage.jpg")
  //      self.image.image = image
        
     //   UIImageView(image: image)
    }
    @IBAction func orderBtn(_ sender: Any) {
  
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        updateReturnPressed() // 轉場傳送資料前更新 self.myCell
        
        self.currentData.ice = self.myCell.iceSegmentC.titleForSegment(at: self.myCell.iceSegmentC.selectedSegmentIndex)
        self.currentData.sugar = self.myCell.sugarSegmentC?.titleForSegment(at: self.myCell.sugarSegmentC.selectedSegmentIndex)
        self.currentData.totalPrice = self.myCell.totalPrice
        self.currentData.count = self.myCell.countField.text
        self.currentData.documentID = self.myCell.documentID.text
        self.currentData.teaName = self.myCell.nameLabel.text
        
        let invalid = "/"
        if self.currentData.documentID == "" || self.currentData.documentID == invalid  {
            chickFirstID()
        }else {
            if segue.identifier == "Finish" {
                if let finishTVC = segue.destination as? FinishTableViewController  {
                    finishTVC.currentData = self.currentData
                    
                    addData() //加入資料庫
                }
            }
        }
            }
    //MARK:Firestore
    func addData() {
        db.collection("orders").document("\(self.currentData.documentID!)").setData([
                                                                                        "name": "\(self.currentData.teaName ?? "")",
                                                                                        "count": "\(self.currentData.count ?? "")",
                                                                                        "price": "$\(self.currentData.totalPrice ?? "")",
                                                                                        "sugar": "\(self.currentData.sugar ?? "")",
                                                                                        "ice" : "\(self.currentData.ice ?? "")",
                                                                                        "image": "\(self.currentData.image ?? "")"])
    }
    
    // 刪除Document
    func deleteDocument() {
        // [START delete_document]
        db.collection("uesrs").document("DC").delete() { err in
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
        db.collection("")
        db.collection("users").whereField("name", isEqualTo: "Max").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                let document = querySnapshot.documents.first
                document?.reference.updateData(["size": "big"], completion: { (error) in
                })
            }
        }
    }


    @objc func onChange(sender: UISegmentedControl) {
        // 當SegmentController 被改變Value執行的方法
       print(sender.titleForSegment(at: sender.selectedSegmentIndex)!)
    //    finishData.ice = sender.titleForSegment(at: sender.selectedSegmentIndex)

    }
    
    //MARK: UITableViewDataSource,UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! MyCell
        if let name = self.currentData.teaName , let price = self.currentData.price{
            let symbol = "$"
            cell.nameLabel.text = name
            cell.priceLable.text = symbol + price
           
        }
        self.currentData.documentID = cell.documentID.text
//        cell.iceSegmentC = UISegmentedControl(items: ["正常", "少冰", "去冰"])
//        cell.sugarSegmentC = UISegmentedControl(items: ["正常", "半糖", "無糖"])
        cell.sugarSegmentC.selectedSegmentIndex = 0 // 預設的位置
        // 當SegmentController 被改變Value執行
        cell.sugarSegmentC.addTarget(self, action: #selector(onChange), for: .valueChanged)
        
        cell.iceSegmentC.selectedSegmentIndex = 0
        cell.iceSegmentC.addTarget(self, action: #selector(onChange), for: .valueChanged)
        cell.stepper.value = 1
        cell.stepper.stepValue = 1
        cell.stepper.autorepeat = true
        cell.stepper.isContinuous = true
        cell.countField.text = "\(Int(cell.stepper.value))"
        cell.stepper.maximumValue = 999
        
        cell.iceLabel.text = "冰塊"
        cell.sugarLabel.text = "甜度"
        cell.countField.placeholder = "杯數"
        cell.moneyLabel.text! = "金額:"
        cell.documentID.placeholder = "訂購人ID"
        
        cell.orderVC = self // 跟跳轉頁面做連結 deleage機制
        cell.updateCellView(cellData: self.currentData)
        self.myCell = cell
        
        return cell
//        if let count = Int(cell.countField.text!), let price = Int(currentData.price!),let id = cell.documentID.text  {
//
//            let totalPrice = price * count
//            cell.totalPrcieLabel.text = "$\(totalPrice)"
//
//            self.finishData.price = cell.totalPrcieLabel.text
//            self.finishData.count = "\(count)"
//            self.finishData.documentID = id
//        }
        // Data = cell
      //  cellData.priceLable.text = currentTeaData.price!
      
    }
    
    func updateReturnPressed() {
      //  let data = TeaData()
        let symbol = "$"
        if let count = Int(self.myCell.countField.text!),count>0,count<1000, let price = Int(self.currentData.price!), let id = self.myCell.documentID.text {
       
            self.myCell.totalPrice = "\(count * price)"
            self.myCell.countField.text = "\(count)"
            self.myCell.stepper.value = Double(count)
            self.myCell.documentID.text = id
            self.myCell.priceLable.text = symbol + "\(self.myCell.totalPrice ?? self.currentData.price!)"

        }else{
            self.myCell.countField.text = "1"
            self.myCell.stepper.value = 1
            self.myCell.countField.text = "\(Int(self.myCell.stepper.value ))"
            self.myCell.priceLable.text = symbol + "\(self.currentData.price!)"
  
          
        }
     }
    func chickFirstID(){
        let alert = UIAlertController(title: "請輸入訂購人", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
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

