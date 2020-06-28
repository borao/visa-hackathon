//
//  Data.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/23/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import Foundation
import UIKit

let categoryToString = [MerchantCaterogy.coffee: "Coffee & Tea", MerchantCaterogy.fastFood: "Fast Food"]

let visaOrange = UIColor(rgb: 0xEF991A)
let visaBlue = UIColor(rgb: 0x0D158C)
let skyBlue = UIColor(rgb: 0x00CCFF)

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
