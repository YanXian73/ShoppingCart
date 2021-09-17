//
//  FinishTableViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/7/6.
//

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseCore

class FinishTableViewController: UITableViewController {

    var documentID = [String]()
    var nameList = [String]()
    var countList = [String]()
    var priceList = [String]()
    var sugarList = [String]()
    var iceList = [String]()
    var imageList = [String]()

    var db : Firestore!
    var currentData: TeaData!
   
   
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        readData()
      //
    }
    
    @IBAction func done(_ sender: Any) {
      //  self.navigationController?.performSegue(withIdentifier: "backmain", sender: nil)
       // self.performSegue(withIdentifier: "backmain", sender: nil)
        self.navigationController?.popToRootViewController(animated: true)
    }
    func readData() {
        
        db.collection("orders").getDocuments { (querySnapshot, error) in
            if let querySnapshot = querySnapshot {
                for document in querySnapshot.documents {
                    self.documentID.append(document.documentID)
                    self.nameList.append(document.data()["name"] as! String )
                    self.priceList.append(document.data()["price"] as! String )
                    self.countList.append(document.data()["count"] as! String )
                    self.iceList.append(document.data()["ice"] as! String )
                    self.sugarList.append(document.data()["sugar"] as! String )
                    self.imageList.append(document.data()["image"] as! String)
                    print(document.data())
                }
                    DispatchQueue.main.async {
                       self.tableView.reloadData()
                        self.tableView.rowHeight = 140
                            //self.tableView.frame.size.height/CGFloat(self.nameList.count)
                    }
                }
            }
    }
    // MARK: - Table view data source, TableViewDeleage
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
      
        
        let alert = UIAlertController(title: "取消此筆訂單", message: "", preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title: "確定取消 ", style: .default, handler: { _ in
            self.db.collection("orders").document("\(self.documentID[indexPath.row])").delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    self.nameList.remove(at:indexPath.row)
                    self.priceList.remove(at:indexPath.row)
                    self.countList.remove(at: indexPath.row)
                    self.sugarList.remove(at:indexPath.row)
                    self.iceList.remove(at: indexPath.row)
                    self.documentID.remove(at:indexPath.row)
                    self.imageList.remove(at: indexPath.row)
                    
                    print("Document successfully removed!")
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                    //      self.tableView.reloadData()
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "等等...", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nameList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "finishcell", for: indexPath) as! MyCell
        let showID = "ID： "
        let space = " "
        cell.documentIDLabel.text = showID + self.documentID[indexPath.row]
        cell.nameLabel.text =  self.nameList[indexPath.row] + space + self.sugarList[indexPath.row] + space + self.iceList[indexPath.row]
        cell.priceLable.text =  self.priceList[indexPath.row]
        cell.totalCountLabel.text = "\(self.countList[indexPath.row])杯"
        cell.finishView.image = UIImage(named: self.imageList[indexPath.row])
//        cell.showSugarLabel.text = self.sugarList[indexPath.row]
//        cell.showIceLabel.text = self.iceList[indexPath.row]
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

