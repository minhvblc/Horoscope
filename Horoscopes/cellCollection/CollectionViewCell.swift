//
//  CollectionViewCell.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/21/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var smallView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
