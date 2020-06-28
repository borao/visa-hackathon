//
//  NSObject+ClassName.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/05/03.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import Foundation

extension NSObject {
    
    static var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
}
