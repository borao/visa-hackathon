//
//  UIImage+Path.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/05/03.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import UIKit

extension UIImage {
    
    class func image(from path: UIBezierPath, strokeColor: UIColor) -> UIImage? {
        let size = path.bounds.insetBy(dx: -path.lineWidth/2, dy: -path.lineWidth/2).size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        strokeColor.setStroke()
        
        path.stroke()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()

        return image
    }
}
