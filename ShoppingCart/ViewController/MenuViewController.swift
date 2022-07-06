//
//  ViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/6/27.
//

import UIKit
import FirebaseAuth

class MenuViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
    //一個飲料清單的購物車
    //MARK: - 變數, 物件
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var leftBarButtonItem: UIBarButtonItem!
    
    let menuViewModel = MenuVCViewModel()
    
    //MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        bindViewModel()
        //通知需要顯示畫面資料
        menuViewModel.isShowView = true
    }
    func initView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = self.tableView.frame.size.height/10
        leftBarButtonItem.title = "登出"
    }
    func bindViewModel() {
        //被通知時執行的動作
        menuViewModel.onRequestEnd = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - func
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            if let orderVC = segue.destination as? OrderViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
                orderVC.viewModel.currentCell = menuViewModel.cellViewModels[indexPath.row]
            }
        }
    }
 
    @IBAction func rightNavigationBtnPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "\(CartTableViewController.self)") as! CartTableViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func leftNavigationBtnPressed(_ sender: Any) {
        let alert = UIAlertController(title: "確定要登出？", message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel)
        let action = UIAlertAction(title: "登出", style: .default) { action in
            do {
                try Auth.auth().signOut()
            }catch {
                print(error)
            }
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "loginVC") {
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
        }
        alert.addAction(action)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITableViewDataSoure, UITableViewDelegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuViewModel.cellViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        
        //通知ViewCell做畫面更新 分工 不要全部都丟在Controller
        cell.setup(viewModel: menuViewModel.cellViewModels[indexPath.row])
        self.tableView.rowHeight = 105

        return cell
    }
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
    
        return self.tableView.frame.size.height/5
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
//        let vc = storyboard?.instantiateViewController(withIdentifier: "\(OrderViewController.self)") as! OrderViewController
//        vc.viewModel.currentCell = menuViewModel.menuCellViewModels[indexPath.row]
//        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}//class

/* navigation 新增按鈕問題
 只有在使用navigationController?.pushViewController 再寫navigationController
 設定navigationItem, bar, title 之類的不要寫navigationController 因為它(navigationController)代表最初的那個
 這樣就好 navigationItem.rightBarButtonItems
 不要這樣 navigationController?.navigationItem.rightBarButtonItems
 媽的害我找了兩個小時
 */

