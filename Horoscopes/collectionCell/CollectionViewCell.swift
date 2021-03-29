//
//  CollectionViewCell.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/21/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var smallView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
