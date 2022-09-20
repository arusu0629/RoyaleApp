//
//  SignInDescriptionView.swift
//  Presentation
//
//  Created by nakandakari on 2020/10/09.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import UIKit

final class SignInDescriptionView: UIView {

    @IBOutlet private weak var collectionView: UICollectionView! {
        willSet {
            newValue.delegate = self
            newValue.dataSource = self
            newValue.register(SignInDescriptionCell.nib, forCellWithReuseIdentifier: SignInDescriptionCell.className)
        }
    }
    @IBOutlet private weak var pageControl: UIPageControl!

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }

    private func initialize() {
        self.loadXib()
    }

    private var descriptionImageData: [UIImage] = []
}

// MARK: - SetupDescriptionImage
extension SignInDescriptionView {

    func setData(_ data: [UIImage]) {
        self.descriptionImageData = data
        self.collectionView.reloadData()
    }
}

extension SignInDescriptionView: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
    }
}

extension SignInDescriptionView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.descriptionImageData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SignInDescriptionCell.className, for: indexPath) as? SignInDescriptionCell else {
            return UICollectionViewCell()
        }
        cell.setupImage(self.descriptionImageData[indexPath.row])
        return cell
    }
}

extension SignInDescriptionView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.bounds.size
    }
}
