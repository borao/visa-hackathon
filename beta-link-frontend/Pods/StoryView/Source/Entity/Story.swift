//
//  Story.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/06/23.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import UIKit

open class Story {
    var image: UIImage
    var title = ""
    var color = UIColor.lightGray
    var borderWidth: CGFloat = 2
    
    public init(image: UIImage, title: String = "", color: UIColor = UIColor.lightGray, borderWidth: CGFloat = 2) {
        self.image = image
        self.title = title
        self.color = color
        self.borderWidth = borderWidth
    }
}
