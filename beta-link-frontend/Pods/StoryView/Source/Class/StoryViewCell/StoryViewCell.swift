//
//  StoryViewCell.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/05/03.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import UIKit

protocol StoryViewCellDelegate: class {
    func tapped(_ cell: StoryViewCell)
    func longPressed(_ cell: StoryViewCell)
}

class StoryViewCell: UICollectionViewCell {
    
    var delegate: StoryViewCellDelegate?
    
    var item = 0
    
    var story: Story! {
        didSet {
            self.setupStory()
        }
    }
    
    @IBOutlet private weak var iconView: UIView!
    
    @IBOutlet private weak var borderImageView: UIImageView!
    
    @IBOutlet private weak var iconImageView: UIImageView!
    
    @IBOutlet private weak var titleLabel: UILabel! {
        willSet {
            newValue.textAlignment = .center
        }
    }
}

extension StoryViewCell {
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        self.setupGesture()
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        self.addGestureRecognizer(tapGesture)
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        self.addGestureRecognizer(longPressGesture)
    }
}

// MARK: - Gesture
extension StoryViewCell {
    
    @objc
    private func tapped(_ sender: UITapGestureRecognizer) {
        self.delegate?.tapped(self)
    }
    
    @objc
    private func longPressed(_ sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .began:
            self.longPressAnimation()
            self.delegate?.longPressed(self)
        default:
            break
        }
    }
}

// MARK: - Setter
extension StoryViewCell {
    
    private func setupStory() {
        self.layoutIfNeeded()
        self.setIcon()
        self.setBorderColor()
        self.setTitle()
    }
    
    private func setIcon()  {
        self.iconImageView.layer.cornerRadius = self.iconImageView.bounds.width * 0.5
        self.iconImageView.image = self.story.image
    }
    
    private func setBorderColor() {
        let image = UIImage.circle(rect: self.borderImageView.bounds,
                                   color: self.story.color,
                                   borderWidth: self.story.borderWidth)
        self.borderImageView.image = image
    }
    
    private func setTitle() {
        self.titleLabel.text = self.story.title
    }
}

// MARK: - Animation
extension StoryViewCell {
    
    private func longPressAnimation() {
        let animation = CASpringAnimation(keyPath: "transform.scale")
        animation.duration = 0.3
        animation.fromValue = 1.1
        animation.toValue = 1.0
        animation.mass = 1.0
        animation.initialVelocity = 30.0
        animation.stiffness = 120.0
        self.iconView.layer.add(animation, forKey: nil)
    }
}
