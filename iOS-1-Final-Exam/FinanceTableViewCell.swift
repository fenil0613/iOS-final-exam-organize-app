//
//  FinanceTableViewCell.swift
//  iOS-1-Final-Exam
//
//  Created by Fenil Bhanavadiya on 2022-12-18.
//

import UIKit

class FinanceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var amountCategory: UILabel!
    @IBOutlet weak var amountTitle: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
