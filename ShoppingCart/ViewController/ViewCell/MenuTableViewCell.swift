//
//  MenuTableViewCell.swift
//  ShoppingCart
//
//  Created by 吳彥賢 on 2022/6/14.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var datilLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    @IBOutlet weak var myImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        
    }
    
    func setup(viewModel: CellViewModel){
        nameLabel.text = viewModel.teaName
        priceLable.text = "$\(viewModel.price)"
        datilLabel.text = viewModel.detail
        myImage.image = UIImage(named: viewModel.image)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
