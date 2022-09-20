//
//  HoverButton.swift
//  Presentation
//
//  Created by nakandakari on 2020/09/05.
//  Copyright © 2020 nakandakari. All rights reserved.
//

import Foundation
import UIKit

protocol HoverCollectionViewCellDelegate: AnyObject {
    func didFinishTapAnimation()
}

class HoverCollectionViewCell: UICollectionViewCell {

    @IBInspectable var needScaleAnimate: Bool = true

    @IBInspectable var scaleDownSize: CGFloat = 0.7
    @IBInspectable var scaleUpSize:   CGFloat = 1.3

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.playScaleDownAnimation()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.playScaleUpAnimation {
            self.clearAnimation {
                self.delegate?.didFinishTapAnimation()
            }
        }
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.clearAnimation()
    }

    weak var delegate: HoverCollectionViewCellDelegate?
}

// MARK: - Tap Animation
extension HoverCollectionViewCell {

    private func playScaleDownAnimation(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.05, animations: {
            self.transform = CGAffineTransform(scaleX: self.scaleDownSize, y: self.scaleDownSize)
        }, completion: { _ in
            completion?()
        })
    }

    private func playScaleUpAnimation(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.05, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: self.scaleDownSize, y: self.scaleDownSize)
        }, completion: { _ in
            completion?()
        })
    }

    private func clearAnimation(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseInOut, animations: {
            self.transform = .identity
        }, completion: { _ in
            completion?()
        })
    }
}
