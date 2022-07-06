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


class OrderViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    //MARK: - 變數
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var image: UIImageView!
    
    let viewModel = OrderVCViewModel()

    //MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindViewModel()
    }
    func initView() {
        tableView.rowHeight = self.tableView.frame.size.height/1
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        image.image = UIImage(named:viewModel.currentCell.image)
        
    }
    func bindViewModel() {
        viewModel.onPushViewDone = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    // 轉場到下一頁 按下加入購物車的時候觸發
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "Finish" else{ return }
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? OrderViewCell,
           let viewModel = cell.cellViewModel {
            let invalid = "/"
            if viewModel.idName == "" || viewModel.idName == invalid  {
                chickFirstID()
            }else {
                FireBase.addData(data: viewModel, db: FireBase.db) //加入資料庫
            }
        }
    }
    //觸碰螢幕 收鍵盤
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - UITableViewDataSource,UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderViewCell
        
        cell.setup(viewModel: viewModel.currentCell)
        
        return cell
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

