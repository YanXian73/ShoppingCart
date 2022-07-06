//
//  ListTableViewCell.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/6/27.
//

import UIKit

class OrderViewCell: UITableViewCell, UITextFieldDelegate  {
    
    //MARK: - 變數
    //以下都是order cell
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var sugarSegmentC: UISegmentedControl!
    @IBOutlet weak var iceSegmentC: UISegmentedControl!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    
    @IBOutlet weak var countField: UITextField!
    @IBOutlet weak var documentID: UITextField! //使用者輸入用
    
    var cellViewModel: CellViewModel?
    
    //MARK: - func
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //判斷OrederViewController畫面有出現才會執行
        if let stepper = stepper {
            stepper.addTarget(self, action: #selector(updateStepper), for: .valueChanged)
            countField.delegate = self
            documentID.delegate = self
            countField.tag = 777
            documentID.tag = 888
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
        cellViewModel?.onCountIsDone = nil
    }
    @objc func updateStepper(){
        //等待更新View
        cellViewModel?.onCountIsDone = { [weak self] total in
            self?.priceLabel.text = "$\(total)"
        }
        countField.text = "\(Int(stepper.value))"
        //通知更新Model, 完成後更新View
        cellViewModel?.count = countField.text
    }
    @objc func onChange() {
        cellViewModel?.sugar = sugarSegmentC.titleForSegment(at: sugarSegmentC.selectedSegmentIndex)
        cellViewModel?.ice = iceSegmentC.titleForSegment(at: iceSegmentC.selectedSegmentIndex)
    }
    
    func setup(viewModel: CellViewModel){
        cellViewModel = viewModel
        
        nameLabel.text = viewModel.teaName
        priceLabel.text = "$\(viewModel.price)"
        detailLabel.text = viewModel.detail
        // 當SegmentController 被改變Value執行
        sugarSegmentC.selectedSegmentIndex = 0 // 預設的位置
        sugarSegmentC.addTarget(self, action: #selector(onChange), for: .valueChanged)
        iceSegmentC.selectedSegmentIndex = 0
        iceSegmentC.addTarget(self, action: #selector(onChange), for: .valueChanged)
        stepper.value = 1
        stepper.stepValue = 1
        stepper.autorepeat = true
        stepper.isContinuous = true
        countField.text = "\(Int(stepper.value))"
        stepper.maximumValue = 999
        stepper.minimumValue = 1
        
        iceLabel.text = "冰塊"
        sugarLabel.text = "甜度"
        countField.placeholder = "杯數"
        moneyLabel.text! = "金額:"
        documentID.placeholder = "訂購人ID"
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.endEditing(true)
    }
    //MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 777: //數量的textField
            //等待ViewModel更新完, View更新
            cellViewModel?.onCountIsDone = { [weak self] totalPrice in
                self?.priceLabel.text = "$\(totalPrice)"
                self?.countField.text = self?.cellViewModel?.count
                //計數器的值也要更新
                let double = Double(self?.cellViewModel?.count ?? "")
                self?.stepper.value = double!
            }
            //ViewModel更新, 完成後通知View更新
            cellViewModel?.count = textField.text
            
        case 888: //訂購人的textField
            documentID.text = textField.text
            cellViewModel?.idName = textField.text
        default:
            break
        }
        textField.resignFirstResponder() // 收鍵盤
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        //...
    }
    
}//class


