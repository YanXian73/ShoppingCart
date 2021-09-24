//
//  ListTableViewCell.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/6/27.
//

import UIKit

class MyCell: UITableViewCell, UITextFieldDelegate  {
//    func updateTotalPrice(cell: MyCell) {
//        if let count = Int(cell.countField.text!), let price = Int(cell.priceLable.text!){
//            self.totalLabel.text = "\(count * price)"
//        }
//    }
    var orderVC : OrderViewController!
    var totalPrice : String?
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var totalCountLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var finishView: UIImageView!
    @IBOutlet weak var documentIDLabel: UILabel!
    @IBOutlet weak var documentID: UITextField!
  
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var sugarSegmentC: UISegmentedControl!
    @IBOutlet weak var iceSegmentC: UISegmentedControl!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    
    @IBOutlet weak var datilLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var myImage: UIImageView!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       
        self.orderVC.updateReturnPressed()
        textField.resignFirstResponder() // 收鍵盤
        
        return true
    }
    override func awakeFromNib() {
        super.awakeFromNib()

      //判斷OrederViewController畫面有出現才會執行
        if let stepper = stepper {
            stepper.addTarget(self, action: #selector(updateStepper), for: .valueChanged)
            self.countField.delegate = self
            self.documentID.delegate = self
         //   self.totalPrcieLabel.text! = "\(Int(price.text!) * Int(textField.text!))"
        }
    }
        @objc func updateStepper(){ 
    
            self.countField.text = "\(Int(self.stepper.value))"
            
            self.orderVC.updateReturnPressed()
        }
    func updateCellView(cellData: TeaData){
        
        self.nameLabel.text = cellData.teaName
        self.priceLable.text = cellData.price
        self.datilLabel.text = cellData.datil
        self.myImage.image = UIImage(named: cellData.image!)
        
        if  cellData.documentID != nil {
            self.countField.text = cellData.count
            
            self.documentID.text = cellData.documentID
            if let count = Int(self.countField.text!) , let price = Int(self.priceLable.text!) {
                let totalPrice = count * price
                self.priceLable.text = "$\(totalPrice)"
            }
        }
        if self.documentIDLabel != nil {
            self.documentIDLabel.text = cellData.documentID
        }
        
    }
   
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}


