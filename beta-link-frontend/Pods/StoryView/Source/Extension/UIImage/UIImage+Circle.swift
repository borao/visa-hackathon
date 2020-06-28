//
//  UIImage+Circle.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/05/19.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import Foundation

extension UIImage {
    
    static func circle(rect: CGRect, color: UIColor, borderWidth: CGFloat) -> UIImage? {
        let pathRect = rect.insetBy(dx: borderWidth/2, dy: borderWidth/2)
        let path = UIBezierPath(ovalIn: pathRect)
        path.lineWidth = borderWidth
        return UIImage.image(from: path, strokeColor: color)
    }
}
