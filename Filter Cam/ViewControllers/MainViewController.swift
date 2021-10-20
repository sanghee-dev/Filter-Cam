//
//  MainViewController.swift
//  Filter Cam
//
//  Created by leeesangheee on 2021/10/20.
//

import UIKit
import SnapKit

final class MainViewController: UIViewController {
    
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
        addFilterBtn()
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
    
    func addFilterBtn() {
        view.addSubview(filterBtn)
        
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
        navigationController?.pushViewController(photoVC, animated: true)
    }
}
