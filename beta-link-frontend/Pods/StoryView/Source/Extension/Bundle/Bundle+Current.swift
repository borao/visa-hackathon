//
//  Bundle+Current.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/05/03.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import Foundation

extension Bundle {
    
    static var current: Bundle {
        class dummyClass{}
        return Bundle(for: type(of: dummyClass()))
    }
}
