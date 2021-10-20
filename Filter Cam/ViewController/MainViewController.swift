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
    
    var selectedImage: UIImage?
    private var filter: Filter = Filters.shared.halftone {
        didSet {
            updateFilterBtn()
        }
    }
    private var isFiltered: Bool = false {
        didSet {
            updateApplyBtn()
        }
    }
    
    private let btnWidth: CGFloat = 80
    private let padding: CGFloat = 16
    private let bottomSpace: CGFloat = 40
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let filterBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 40
        
        btn.isHidden = true
        return btn
    }()
        
    private let applyBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("적용", for: .normal)
        btn.titleLabel?.font = .boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 40
        
        btn.isHidden = true
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupNavigationBar()
        setupFilterBtn()
        addSubViews()
        setupBtns()
    }
}

private extension MainViewController {
    @objc func showActionSheet() {
        let alert = UIAlertController(title: "사진 필터", message: "사진 필터를 선택해주세요", preferredStyle: .actionSheet)
        
        let halftoneAction = UIAlertAction(title: Filters.shared.halftone.name, style: .default) { [weak self] _ in
            self?.filter = Filters.shared.halftone
            self?.isFiltered = false
        }
        let sepiatoneAction = UIAlertAction(title: Filters.shared.sepiaTone.name, style: .default) { [weak self] _ in
            self?.filter = Filters.shared.sepiaTone
            self?.isFiltered = false
        }
        let effectMonoAction = UIAlertAction(title: Filters.shared.effectMono.name, style: .default) { [weak self] _ in
            self?.filter = Filters.shared.effectMono
            self?.isFiltered = false
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(halftoneAction)
        alert.addAction(sepiatoneAction)
        alert.addAction(effectMonoAction)
        alert.addAction(cancelAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

private extension MainViewController {
    func setupBtns() {
        filterBtn.addTarget(self, action: #selector(showActionSheet), for: .touchUpInside)
        applyBtn.addTarget(self, action: #selector(applyBtnTapped), for: .touchUpInside)
    }
    
    @objc func applyBtnTapped() {
        switch isFiltered {
        case true: undoFilter()
        case false: applyFilter()
        }
    }
    
    func applyFilter() {
        guard let selectedImage = selectedImage else { return }
        applyBtn.isEnabled = false
        
        FilterService.shared.applyFilter(to: selectedImage, filterKey: filter.CIKey)
            .subscribe(onNext: { [weak self] filteredImage in
                self?.photoImageView.image = filteredImage
            }).disposed(by: disposeBag)
        
        isFiltered = true
        applyBtn.isEnabled = true
    }
    
    func updateFilterBtn() {
        filterBtn.setTitle(filter.name, for: .normal)
        filterBtn.backgroundColor = filter.color
    }
    
    func updateApplyBtn() {
        switch isFiltered {
        case true:
            applyBtn.setTitle("취소", for: .normal)
            applyBtn.backgroundColor = .systemRed
        case false:
            applyBtn.setTitle("적용", for: .normal)
            applyBtn.backgroundColor = .systemBlue
        }
    }
    
    func updateApplyBtnTrue() {
        applyBtn.setTitle("적용", for: .normal)
        applyBtn.backgroundColor = .systemBlue
    }
    
    func undoFilter() {
        photoImageView.image = selectedImage
        
        isFiltered = false
        
        updateApplyBtn()
    }
}

private extension MainViewController {
    func setupNavigationBar() {
        navigationItem.title = Information.shared.appName
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarBtnTapped))
    }
    
    @objc func addBarBtnTapped() {
        let photoVC = PhotoCollectionViewController()
        
        photoVC.selectedPhoto.subscribe(onNext: { [weak self] image in
            self?.selectedImage = image
            self?.photoImageView.image = image
            self?.filterBtn.isHidden = false
            self?.applyBtn.isHidden = false
        }).disposed(by: disposeBag)
        
        navigationController?.pushViewController(photoVC, animated: true)
    }
    
    func setupFilterBtn() {
        filterBtn.setTitle(filter.name, for: .normal)
        filterBtn.backgroundColor = filter.color
    }
    
    func addSubViews() {
        view.addSubview(photoImageView)
        view.addSubview(filterBtn)
        view.addSubview(applyBtn)
        
        photoImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(btnWidth + bottomSpace + padding)
        }
        
        filterBtn.snp.makeConstraints {
            $0.left.equalTo(view.frame.width / 2 - padding / 2 - btnWidth)
            $0.bottom.equalToSuperview().inset(bottomSpace)
            $0.width.height.equalTo(btnWidth)
        }
        
        applyBtn.snp.makeConstraints {
            $0.left.equalTo(view.frame.width / 2 + padding / 2)
            $0.bottom.equalToSuperview().inset(bottomSpace)
            $0.width.height.equalTo(btnWidth)
        }
    }
}
