//
//  PhotoCollectionViewCell.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import SnapKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "PhotoCollectionViewCell"
    
    var photo: UIImage? {
        didSet {
            imageView.image = photo
        }
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGroupedBackground
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension PhotoCollectionViewCell {
    func addImageView() {
        addSubview(imageView)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.left.right.equalToSuperview()
        }
    }
}
