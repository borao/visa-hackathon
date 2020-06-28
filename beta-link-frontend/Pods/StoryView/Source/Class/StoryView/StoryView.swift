//
//  StoryView.swift
//  StoryView
//
//  Created by Tomosuke Okada on 2018/05/03.
//  Copyright © 2018年 TomosukeOkada. All rights reserved.
//

import UIKit

public protocol StoryViewDataSource: class {
    func numberOfItems(in storyView: StoryView) -> Int
    func storyView(_ storyView: StoryView, storyForItem item: Int) -> Story
}

public protocol StoryViewDelegate: class {
    func storyView(_ storyView: StoryView, tappedCellAt item: Int)
    func storyView(_ storyView: StoryView, longPressedCellAt item: Int)
}

open class StoryView: UIView {
    
    public weak var dataSource: StoryViewDataSource?
    
    public weak var delegate: StoryViewDelegate?

    private var collectionView: UICollectionView!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    private func initialize() {
        self.setupCollectionView()
    }
}

extension StoryView {
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        self.collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        self.collectionView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UINib(nibName: StoryViewCell.className, bundle: Bundle.current), forCellWithReuseIdentifier: StoryViewCell.className)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.addSubview(self.collectionView)
    }
}


// MARK: - UICollectionViewDataSource
extension StoryView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource?.numberOfItems(in: self) ?? {
            fatalError("Method 'numberOfItems(in storyView: StoryView) -> Int' in protocol not implemented.")
            }() as! Int
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: StoryViewCell.className, for: indexPath) as! StoryViewCell
        cell.delegate = self
        cell.item = indexPath.item
        cell.story = self.dataSource?.storyView(self, storyForItem: indexPath.item)
        return cell
    }
}

extension StoryView: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.height, height: collectionView.bounds.height)
    }
}

// MARK: - StoryViewCellDelegate
extension StoryView: StoryViewCellDelegate {
    
    func tapped(_ cell: StoryViewCell) {
        self.delegate?.storyView(self, tappedCellAt: cell.item)
    }
    
    func longPressed(_ cell: StoryViewCell) {
        self.delegate?.storyView(self, longPressedCellAt: cell.item)
    }
}
