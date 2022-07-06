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

class CartTableViewController: UITableViewController {
    //MARK: - 變數
    var documentID = [String]()
    var nameList = [String]()
    var countList = [String]()
    var priceList = [String]()
    var sugarList = [String]()
    var iceList = [String]()
    var imageList = [String]()
    
    let viewModel = CartVCViewModel()
    
    //MARK: - 生命週期
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        bindViewModel()
        viewModel.readData()
    }
    //MARK: - func
    func setNavigation() {
        let btn1 = UIBarButtonItem(title: "繼續選購", style: .done, target: self, action: #selector(continueShopping))
        navigationItem.rightBarButtonItems = [editButtonItem, btn1]
    }
    func bindViewModel() {
        viewModel.onReadDataDone = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
        viewModel.onDeleteDateDone = { [weak self] _indexPath in
            DispatchQueue.main.async {
                if self?.viewModel.cartListCell.count == 0 { //如果購物車沒有資料
                    //self?.tableView.deleteRows(at: [_indexPath, IndexPath(row: 0, section: 1)], with: .automatic)
                    self?.tableView.deleteSections(IndexSet([0]), with: .automatic)
                    self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic) //更新計算欄位
                }else {
                    self?.tableView.deleteRows(at: [_indexPath], with: .automatic)
                    self?.tableView.reloadRows(at: [IndexPath(row: 0, section: 1)], with: .automatic) //更新計算欄位
                }
            }
        }
    }
    @objc func continueShopping() {
        navigationController?.popToRootViewController(animated: true)
    }
    @objc func editing() {
        tableView.setEditing(!self.tableView.isEditing, animated: true)
    }
//    override func setEditing(_ editing: Bool, animated: Bool) {
//        super.setEditing(editing, animated: animated)
//        tableView.setEditing(editing, animated: true)
//    }

    // MARK: - Table view data source, TableViewDeleage
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, viewModel.cartListCell.count != 0 {
            self.tableView.deselectRow(at: indexPath, animated: true)
            let alert = UIAlertController(title: "取消此筆訂單", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "確定取消 ", style: .default, handler: { _ in
                self.viewModel.deleteData(indexPath: indexPath)
            }))
            alert.addAction(UIAlertAction(title: "等等...", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
        
    override func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.cartListCell.count == 0 {
            return 1
        }
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard viewModel.cartListCell.count != 0 else {
            return 1
        }
        if section == 0 {
            return viewModel.cartListCell.count
        }else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if viewModel.cartListCell.count == 0 { //購物車是空的
                let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell2", for: indexPath) as! CartTableViewCell
                cell.cartEmptyLabel.text = "購物車是空的"
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
            cell.setup(viewModel: viewModel.cartListCell[indexPath.row])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell1", for: indexPath) as! CartTableViewCell
            cell.selectionStyle = .none
            cell.totalCount.text = viewModel.totalCount! + "杯"
            cell.totalPrice.text = viewModel.totalPrice! + "元"
            cell.totalLabel.text = "總共"
            return cell
        default:
            break
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
       return nil
    }
}// class

