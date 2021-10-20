//
//  Filters.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/21.
//

import UIKit

struct Filters {
    
    static let shared = Filters()
    
    let halftone = Filter(CIKey: "CICMYKHalftone",
                          name: "하프톤",
                          color: .systemPink)
    
    let sepiaTone = Filter(CIKey: "CICMYKHalftone", // CISepiaTone
                           name: "세피아톤",
                           color: .brown)
    
    let effectMono = Filter(CIKey: "CICMYKHalftone", // CIEffectMono
                            name: "모노톤",
                            color: .systemGray)
}
