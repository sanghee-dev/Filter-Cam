//
//  Filters.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/21.
//

import UIKit
import CoreImage

struct Filters {
    
    static let shared = Filters()
    
    let halftone = Filter(filterKey: kCIInputWidthKey,
                          filterName: "CICMYKHalftone",
                          title: "하프톤",
                          color: .systemPink)
    
    let sepiaTone = Filter(filterKey: kCIInputIntensityKey,
                           filterName: "CISepiaTone",
                           title: "세피아톤",
                           color: .brown)
    
    let effectMono = Filter(filterKey: kCIInputImageKey,
                            filterName: "CIColorMonochrome",
                            title: "모노톤",
                            color: .systemGray)
}
