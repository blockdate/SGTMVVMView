//
//  ShoppingListViewCell.swift
//  Demo
//
//  Created by 吴磊 on 2017/2/14.
//  Copyright © 2017年 wleo block. All rights reserved.
//

import UIKit

class ShoppingListViewCell: SGTMVVMSwipeTableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countStepper: UIStepper!
    @IBOutlet weak var countLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func bind(_ viewModel: SGTMVVMReuseViewModelProtocol) {
        super.bind(viewModel)
        if let VM = viewModel as? ShoppingListCellModel{
            self.nameLabel.text = VM.title
//            RACObserve(VM, keyPath: "count").take(until: self.rac_prepareForReuseSignal) ~> SGTRAC(self.countLabel,"text","1")
//            RACObserve(VM, keyPath: "price").take(until: self.rac_prepareForReuseSignal) ~> SGTRAC(self.priceLabel,"text","0.00")
        }
    }
    
}
