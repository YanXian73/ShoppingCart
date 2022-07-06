//
//  DrinkTea.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2021/7/5.
//

import Foundation


struct TeaData {

    var teaName : String
    var image : String
    var price : String
    var count : String?
    var detail : String
    
    var sugar : String? = nil
    var ice : String? = nil
    var totalPrice : String? = nil
    var documentID: String? = nil
    
   static func getAllTeaData() -> [TeaData] {
        //獲取資料
        return [TeaData(teaName: "熟成紅茶", image: "熟成紅茶.jpg", price: "35", count: "1", detail: "說明: 帶有去油解膩的功效"),
                       TeaData(teaName: "熟成冷露", image: "熟成冷露.jpg", price: "35", count: "1", detail: "說明: 綠茶"),
                       TeaData(teaName: "鐵觀音紅茶", image: "鐵觀音紅茶.jpg", price: "40", count: "1", detail: "描述:鐵觀音＋紅茶的完美組合"),
                       TeaData(teaName: "雨果紅茶", image: "雨果紅茶.jpg", price: "35", count: "1", detail: "說明: 茶味較重的紅茶"),
                       TeaData(teaName: "紅水烏龍", image: "紅水烏龍.jpg", price: "40", count: "1", detail: "說明: 烏龍＋紅茶的完美組合"),
                       TeaData(teaName: "雨果那堤珍珠", image: "雨果那堤珍珠.jpg", price: "60", count: "1", detail: "招牌：雨果紅茶＋牛奶＋珍珠"),
                       TeaData(teaName: "８冰冷露", image: "８冰冷露.jpg", price: "50", count: "1", detail: "說明: 清涼消暑的好選擇"),
                       TeaData(teaName: "青檸雷夢", image: "青檸雷夢.jpg", price: "55", count: "1", detail: "說明: 冰涼檸檬＋綠茶"),
                       TeaData(teaName: "布丁奶茶", image: "布丁奶茶.jpg", price: "50", count: "1", detail: "說明: 阿薩姆紅茶＋布丁"),
                       TeaData(teaName: "鐵觀音", image: "鐵觀音.jpg", price: "30", count: "1", detail: "說明: 獨家經典鐵觀音好喝")]
    }

}//class
