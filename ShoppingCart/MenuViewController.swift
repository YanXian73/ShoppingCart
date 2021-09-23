//
//  ViewController.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/6/27.
//

import UIKit

class MenuViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate {
//一個飲料清單的購物車

    let teaCell = [TeaData(teaName: "熟成紅茶", image: "熟成紅茶.jpg", price: "35", count: "1", datil: "帶有去油解膩的功效"),
                   TeaData(teaName: "熟成冷露", image: "熟成冷露.jpg", price: "35", count: "1", datil: "綠茶"),
                   TeaData(teaName: "鐵觀音紅茶", image: "鐵觀音紅茶.jpg", price: "40", count: "1", datil: "鐵觀音＋紅茶的完美組合"),
                   TeaData(teaName: "雨果紅茶", image: "雨果紅茶.jpg", price: "35", count: "1", datil: "茶味較重的紅茶"),
                   TeaData(teaName: "紅水烏龍", image: "紅水烏龍.jpg", price: "40", count: "1", datil: "烏龍＋紅茶的完美組合"),
                   TeaData(teaName: "雨果那堤珍珠", image: "雨果那堤珍珠.jpg", price: "60", count: "1", datil: "招牌：雨果紅茶＋牛奶＋珍珠"),
                   TeaData(teaName: "８冰冷露", image: "８冰冷露.jpg", price: "50", count: "1", datil: "清涼消暑的好選擇"),
                   TeaData(teaName: "青檸雷夢", image: "青檸雷夢.jpg", price: "55", count: "1", datil: "冰涼檸檬＋綠茶"),
                   TeaData(teaName: "布丁奶茶", image: "布丁奶茶.jpg", price: "50", count: "1", datil: "阿薩姆紅茶＋布丁"),
                   TeaData(teaName: "鐵觀音", image: "鐵觀音.jpg", price: "30", count: "1", datil: "獨家經典鐵觀音好喝")]
    
    @IBOutlet weak var tableView: UITableView!
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = self.tableView.frame.size.height/10
    
    
        
    }
//    @IBAction func segueFinishView(_ sender: Any) {
//        self.performSegue(withIdentifier: "gofinish", sender: nil) //轉場方式之一 : 會觸發 prepare(for segue
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Segue" {
            if let orderVC = segue.destination as? OrderViewController,
            let indexPath = self.tableView.indexPathForSelectedRow {
                orderVC.currentData = self.teaCell[indexPath.row]
               
            }
        }
    }
 
    
//MARk:UITableViewDataSoure
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teaCell.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyCell
        
        
        cell.updateCellView(cellData: self.teaCell[indexPath.row])
        cell.priceLable.text = "$\(cell.priceLable.text ?? "")"
        self.tableView.rowHeight = 105
//        if let name = tea.teaName, let price = tea.price, let datil = tea.datil {
//            cell.nameLabel.text = "\(name)"
//            cell.priceLable.text = "$\(price)"
//            cell.datilLabel.text = "\(datil)"
//        }
        return cell
    }
    
    private func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) -> CGFloat {
    
        return self.tableView.frame.size.height/5
    }
    
    //MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}


