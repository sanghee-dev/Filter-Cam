//
//  MainViewController.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import RxSwift
import SnapKit

final class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let filterBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Filter", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemTeal
        btn.layer.cornerRadius = 40
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigationBar()
        addSubViews()
        setupFilterBtn()
    }
}

private extension MainViewController {
    func setupFilterBtn() {
        filterBtn.addTarget(self, action: #selector(filterBtnTapped), for: .touchUpInside)
    }
    
    @objc func filterBtnTapped() {
        print("Filter Button Tapped")
    }
    
    func addSubViews() {
        view.addSubview(photoImageView)
        view.addSubview(filterBtn)
        
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80 + 40 + 16)
        }
        
        filterBtn.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(40)
            $0.width.height.equalTo(80)
        }
    }
}

private extension MainViewController {
    func setupNavigationBar() {
        navigationItem.title = "Filter Cam"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBtnTapped))
    }
    
    @objc func addBtnTapped() {
        let photoVC = PhotoCollectionViewController()
        
        photoVC.selectedPhoto.subscribe(onNext: { [weak self] image in
            self?.photoImageView.image = image
        }).disposed(by: disposeBag)
        
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
