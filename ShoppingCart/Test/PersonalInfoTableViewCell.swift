//
//  PersonalInfoTableViewCell.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/9/24.
//

import UIKit
import Firebase

class PersonalInfoTableViewCell: UITableViewCell {
    
    var userData = [UserData]()
    var db : Firestore!

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var emailTextLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var adderssTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func saveBtnPressed(_ sender: Any) {
        let user = UserData()
        user.name = nameTextField.text
        user.address = adderssTextField.text
        user.birthday = birthdayTextField.text
        user.phone = phoneTextField.text
        
        db.collection("UserData").document("\(emailTextLabel.text!)").setData(["Name: ":"\(nameTextField.text ?? "")",
                                                                        "Birthday: ":"\(birthdayTextField.text ?? "")",
                                                                        "Address: ":"\(adderssTextField.text ?? "")",
                                                                        "Phone: ":"\(phoneTextField.text ?? "")"])
    }
}
