//
//  DruidCellCollectionViewCell.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/14/21.
//

import UIKit

class DruidCellCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        label.textAlignment = .center
        label.font = label.font.withSize(20)
    }

}
