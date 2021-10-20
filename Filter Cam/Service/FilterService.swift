//
//  FilterService.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import CoreImage

final class FilterService {
    
    static let shared = FilterService()
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, filterKey: String, completion: @escaping ((UIImage) -> ())) {
        guard let filter = CIFilter(name: filterKey) else { return }
        filter.setValue(5.0, forKey: kCIInputWidthKey)
        
        let sourceImage = CIImage(image: inputImage)
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return }
        let formRect = outputImage.extent
        
        guard let cgImage = context.createCGImage(outputImage, from: formRect) else { return }
        let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        completion(processedImage)
    }
}
