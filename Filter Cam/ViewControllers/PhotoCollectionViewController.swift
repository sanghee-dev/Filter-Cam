//
//  PhotoCollectionViewController.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import Photos
import RxSwift
import SnapKit

final class PhotoCollectionViewController: UIViewController {
    
    private let selectedPhotoSubject = PublishSubject<UIImage>()
    var selectedPhoto: Observable<UIImage> {
        return selectedPhotoSubject.asObservable()
    }
    
    private var photoAssets: [PHAsset] = []
    
    private let padding: CGFloat = 16
    private let column: CGFloat = 3
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addCollectionView()
        setupCollectionView()
        requestPhotoAuthorization()
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.identifier)
    }
    
    func reloadCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photoAssets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.identifier, for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
        
        let asset = photoAssets[photoAssets.count - indexPath.row - 1]
        let targetSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        PHImageManager.default().requestImage(for: asset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { image, _ in
            cell.photo = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - ((column - 1) * padding)) / column
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        padding
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        padding
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = photoAssets[photoAssets.count - indexPath.row - 1]
        let targetSize = CGSize(width: view.frame.width, height: view.frame.height)
        
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: targetSize, contentMode: .aspectFit, options: nil) { [weak self] image, info in
            
            guard let image = image, let info = info, let isDegradedImage = info[Information.shared.isDegradeKey] as? Bool else { return }

            if !isDegradedImage {
                self?.selectedPhotoSubject.onNext(image)
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

private extension PhotoCollectionViewController {
    func requestPhotoAuthorization() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { [weak self] asset, _, _ in
                    self?.photoAssets.append(asset)
                }
                self?.reloadCollectionView()
            }
        }
    }
    
    func addCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.left.right.equalToSuperview().inset(padding)
        }
    }
}
