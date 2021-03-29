//
//  setDynamicFontSize.swift
//  Horoscopes
//
//  Created by Nguyen Duc Minh on 1/25/21.
//

import Foundation
import UIKit
class Common {
    
    class func setButtonTextSizeDynamic(button: UIButton, textStyle: UIFont.TextStyle) {
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: textStyle)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
}
