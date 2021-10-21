//
//  FilterService.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import CoreImage
import RxSwift

final class FilterService {
    
    static let shared = FilterService()
    
    private var context: CIContext
    
    init() {
        self.context = CIContext()
    }
    
    func applyFilter(to inputImage: UIImage, filterKey: String, filterName: String) -> Observable<UIImage> {
        return Observable<UIImage>.create { observer in
            self.applyFilterToImage(to: inputImage, filterKey: filterKey, filterName: filterName) { filteredImage in
                observer.onNext(filteredImage)
            }
            
            return Disposables.create()
        }
    }
    
    private func applyFilterToImage(to inputImage: UIImage, filterKey: String, filterName: String, completion: @escaping ((UIImage) -> ())) {
        guard let filter = CIFilter(name: filterName) else { return }
        filter.setValue(1.0, forKey: filterKey)
        
        let sourceImage = CIImage(image: inputImage)
        filter.setValue(sourceImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return }
        let formRect = outputImage.extent
        
        guard let cgImage = context.createCGImage(outputImage, from: formRect) else { return }
        let processedImage = UIImage(cgImage: cgImage, scale: inputImage.scale, orientation: inputImage.imageOrientation)
        
        completion(processedImage)
    }
}
