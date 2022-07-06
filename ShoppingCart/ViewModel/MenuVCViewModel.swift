//
//  MenuViewModel.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/14.
//

import Foundation

class MenuVCViewModel {
    
    // 觀察者模式 當資料發生變化 執行方法
    var isShowView: Bool = false {
        didSet{
            if isShowView {
                prepareRequest()
            }
        }
    }
    // Models
    private var teaDatas = [TeaData]()
    private(set) var cellViewModels: [CellViewModel] = []
    
    /// 當請求資料結束, 通知View更新畫面
    var onRequestEnd: (() -> Void)?
    
    private func prepareRequest() {
        teaDatas = TeaData.getAllTeaData()
        for tea in teaDatas {
            let menuCellViewModel = CellViewModel(name: tea.teaName, price: tea.price, detail: tea.detail, image: tea.image)
            cellViewModels.append(menuCellViewModel)
        }
        onRequestEnd?()
    }
}//class
