//
//  CacheImage.swift
//  CacheImage
//
//  Created by tham gia huy on 6/12/18.
//  Copyright © 2018 tham gia huy. All rights reserved.
//

import Foundation

class CacheImage {
    static var images: NSCache<NSString, AnyObject> = {
        var result = NSCache<NSString, AnyObject>()
        result.countLimit = 20
        result.totalCostLimit = 10 * 1024 * 1024
        return result
    }()
}
