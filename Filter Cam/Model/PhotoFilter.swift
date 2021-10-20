//
//  PhotoFilter.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import Foundation

struct PhotoFilter {
    
    static let shared = PhotoFilter()
    
    let halftone = "CICMYKHalftone"
    let sepiatone = "CISepiaTone"
    let effectMono = "CIEffectMono"
    let colorInvert = "CIColorInvert"
}
