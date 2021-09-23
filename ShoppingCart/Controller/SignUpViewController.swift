//
//  SignUpViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/9/21.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.placeholder = "請輸入電子郵件"
        passwordTextField.placeholder = "請輸入密碼"
        passwordTextField.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
 
    
  @IBAction  func creatAccountAction() {
        if emailTextField.text  == "" {
            let alert = UIAlertController(title: "Error", message: "Please Enter your email and password ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true)
        }else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                guard let user = result?.user , error == nil else {
                    print(error!.localizedDescription)
                    return
                }
                print("Your successfully signed up: \(user.email!), password : \(user.uid)")
                
                let alert = UIAlertController(title: "Successfully signed up", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default, handler: {_ in
                    self.dismiss(animated: true)
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
  }// method
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
