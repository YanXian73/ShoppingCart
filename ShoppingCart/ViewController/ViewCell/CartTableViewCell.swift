//
//  CartTableViewCell.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/17.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var _imageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var teaName: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var sugarLabel: UILabel!
    @IBOutlet weak var iceLabel: UILabel!
    
    
    @IBOutlet weak var totalCount: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    @IBOutlet weak var cartEmptyLabel: UILabel!
    
    
    var cellViewModel: CellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if totalCount == nil, cartEmptyLabel == nil {
            commonInit()
        }else {
            backgroundColor = UIColor(named: "bottom")
        }
    }
    
    private func commonInit() {
        iceLabel.font = UIFont.systemFont(ofSize: 15)
        iceLabel.textColor = UIColor(named: "ice")
        sugarLabel.textColor = UIColor(named: "sugar")
        sugarLabel.font = UIFont.systemFont(ofSize: 15)

    }
    func setup(viewModel: CellViewModel) {
        cellViewModel = viewModel
        _imageView.image = UIImage(named: viewModel.image)
        idLabel.text = viewModel.idName! + "  的"
        teaName.text = viewModel.teaName
        count.text = viewModel.count! + "杯"
        price.text = viewModel.totalPrice! + "元"
        sugarLabel.text = viewModel.sugar
        iceLabel.text = viewModel.ice
       
    }

    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
