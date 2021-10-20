//
//  PhotoCollectionViewController.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import Photos
import SnapKit

class PhotoCollectionViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private var photoAssets: [PHAsset] = []
    
    private let padding: CGFloat = 16
    private let column: CGFloat = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        addCollectionView()
        setupCollectionView()
        requestPhotoAuthorization()
    }
}

private extension PhotoCollectionViewController {
    func requestPhotoAuthorization() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assets = PHAsset.fetchAssets(with: .image, options: nil)
                assets.enumerateObjects { asset, count, unSafePointer in
                    self?.photoAssets.append(asset)
                }
                self?.collectionView.reloadData()
            }
        }
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as UICollectionViewCell
        cell.backgroundColor = .systemGroupedBackground
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
        print(indexPath.row)
    }
}

private extension PhotoCollectionViewController {
    func addCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.bottom.left.right.equalToSuperview().inset(padding)
        }
    }
}
