//
//  LoginViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/9/22.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    //MARK: - 變數, 物件
    var pwTextField: UITextField!
    var action: UIAlertAction!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    //MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()

        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
       
        let alert = UIAlertController(title: "註冊", message: "Sign Up", preferredStyle: .alert)
        alert.addTextField { emailTextField in
            emailTextField.placeholder = "請輸入Email"
        }
        alert.addTextField { passwordTextField in
            passwordTextField.placeholder = "請輸入密碼"
            passwordTextField.isSecureTextEntry = true
            self.pwTextField = passwordTextField
        }
        alert.addTextField { passwordTextField in
            passwordTextField.placeholder = "確認輸入密碼"
            passwordTextField.isSecureTextEntry = true
            passwordTextField.addTarget(self, action: #selector(self.passwordCheck(sender:)), for: .editingChanged)
        }
        
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        action = UIAlertAction(title: "確認", style: .default) { action in
            let account = alert.textFields?[0].text
            //檢查輸入的密碼是否一樣
            guard let password = alert.textFields?[1].text, password == alert.textFields?[2].text else { return }
            Auth.auth().createUser(withEmail: account ?? "", password: password) { result, error in
                guard let user = result?.user , error == nil else {
                    print(error!.localizedDescription)
                    let alert = UIAlertController(title: error!.localizedDescription , message: "", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "ok", style: .default, handler: {_ in
                       self.dismiss(animated: true)
                    })
                    alert.addAction(ok)
                    self.present(alert, animated: true)
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
        action.isEnabled = false
        alert.addAction(cancel)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
//        if let vc = storyboard?.instantiateViewController(withIdentifier: "signUp") {
//            let navi = UINavigationController(rootViewController: vc)
//            vc.isModalInPresentation = true
//            vc.modalPresentationStyle = .custom
//            present(navi, animated: true, completion: nil)
//        }
    }
    @objc func passwordCheck(sender: UITextField) {
        if pwTextField.text?.count ?? 0 >= 6, pwTextField.text == sender.text {
            action.isEnabled = true
        }else {
            action.isEnabled = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     
    }
    @IBAction func loginAction(_ sender: Any) {
        if emailTextField.text  == "" {
            let alert = UIAlertController(title: "Error", message: "Please Enter your email and password ", preferredStyle: .alert)
            let ok = UIAlertAction(title: "ok", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true)
        }else {
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { result, error in
                guard let user = result?.user , error == nil else {
                    GeneralFunc.showAlert(title: "Error", message: error?.localizedDescription, vc: self)
                    print(error!.localizedDescription)
                    return
                }
                print("Your successfully Login: \(user.email!), password : \(user.uid)")
                
                let alert = UIAlertController(title: "Successfully Login", message: "", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default, handler: { _ in
                    //self.dismiss(animated: true)
                    if let firstVC = self.storyboard?.instantiateViewController(identifier: "firstVC") {
                        firstVC.modalPresentationStyle = .fullScreen
                        self.present(firstVC, animated: true, completion: nil)
                    }
                })
                alert.addAction(ok)
                self.present(alert, animated: true)
            }
        }
    }
    
   static func checkLogin(window: UIWindow){
        
        if let user = Auth.auth().currentUser {
            print("Your successfully Login: \(user.email!), uid : \(user.uid)")
            
        }else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            // let logVC = storyboard.instantiateViewController(identifier: "loginVC")
            let logVC =  storyboard.instantiateViewController(withIdentifier: "loginVC")
            window.rootViewController = logVC
        }
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
