//
//  HomeViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/22/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit
import StoryView
import SwiftUI
import SQLite

class HomeViewController: UIViewController, UISearchBarDelegate, StoryViewDelegate, StoryViewDataSource, UIScrollViewDelegate, CustomVC {
    /* - MARK: Data input */
    var selectedRecipientName: String?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 0
    var frameWidth: CGFloat?
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        frameWidth = self.view.frame.width
        let scrollView = UIScrollView()
        scrollView.delegate = self
        let tapRecognizer = UITapGestureRecognizer(target: scrollView, action: #selector(UIView.endEditing(_:)))
        scrollView.addGestureRecognizer(tapRecognizer)
        scrollView.backgroundColor = .white
        scrollView.isUserInteractionEnabled = true
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        scrollView.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        scrollView.addSubview(generateSearchBar())
        scrollView.addSubview(generateTopCategory())
        scrollView.addSubview(generateBottomCategory())
        scrollView.addSubview(generateSeparationLine(sender: self))
        scrollView.addSubview(generateSectionHeaderLabel(text: "Your Favorites"))
        scrollView.addSubview(generateStoryView())
        scrollView.addSubview(generateSeparationLine(sender: self))
        scrollView.addSubview(generateSectionHeaderLabel(text: "Recommendation"))
        for merchant in allMerchants {
            let name = merchant.name
            let category = merchant.category
            let hour = "Hours: Sat - Sun, 11:00AM - 5:00PM"
            scrollView.addSubview(generateRecommendation(imgName: "tfl", merchantName: name, merchantCategory: category, merchantHour: hour))
        }
        scrollView.addSubview(generateViewMoreButton(text: "View More"))
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
//        scrollView.addSubview(generatePadding())
        // Do any additional setup after loading the view.
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    func generateSearchBar() -> UISearchBar {
            let bar = UISearchBar()
            let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
            bar.frame = frame
            bar.barTintColor = visaBlue
            bar.searchTextField.backgroundColor = .white
            bar.resignFirstResponder()
            bar.isUserInteractionEnabled = true
    //        bar.delegate = self
            bar.becomeFirstResponder()
            currentHeight += 50 + spacer
            return bar
        }
    
    /* - MARK: Generate Category */
    
    func generateTopCategory() -> UIView {
        let firstImg = UIImage(named: "coffee")
        let firstImgView = UIImageView(image: firstImg)
        firstImgView.isUserInteractionEnabled = true
        firstImgView.contentMode = .scaleAspectFit
        firstImgView.clipsToBounds = true
        firstImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer.category = .food
        tapRecognizer.recipientName = self.selectedRecipientName
        firstImgView.addGestureRecognizer(tapRecognizer)

        let secondImg = UIImage(named: "fast_food")
        let secondImgView = UIImageView(image: secondImg)
        secondImgView.isUserInteractionEnabled = true
        secondImgView.contentMode = .scaleAspectFit
        secondImgView.clipsToBounds = true
        secondImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer2 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer2.category = .clothing
        tapRecognizer2.recipientName = self.selectedRecipientName
        secondImgView.addGestureRecognizer(tapRecognizer2)

        let thirdImg = UIImage(named: "dessert")
        let thirdImgView = UIImageView(image: thirdImg)
        thirdImgView.isUserInteractionEnabled = true
        thirdImgView.contentMode = .scaleAspectFit
        thirdImgView.clipsToBounds = true
        thirdImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer3 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer3.category = .grocery
        thirdImgView.addGestureRecognizer(tapRecognizer3)
        
        let stack = generateEvenContainerView(subViews: [firstImgView, secondImgView, thirdImgView], x: 20, y: currentHeight, width: frameWidth! - 40, height: 120, verticleSpacing: 0, horizontalSpacing: 0, sender: self)
        
        return stack
    }
    
    func generateBottomCategory() -> UIView {
        let firstImg = UIImage(named: "clothing")
        let firstImgView = UIImageView(image: firstImg)
        firstImgView.isUserInteractionEnabled = true
        firstImgView.contentMode = .scaleAspectFit
        firstImgView.clipsToBounds = true
        firstImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer.category = .beauty
        tapRecognizer.recipientName = self.selectedRecipientName
        firstImgView.addGestureRecognizer(tapRecognizer)

        let secondImg = UIImage(named: "grocery")
        let secondImgView = UIImageView(image: secondImg)
        secondImgView.isUserInteractionEnabled = true
        secondImgView.contentMode = .scaleAspectFit
        secondImgView.clipsToBounds = true
        secondImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer2 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer2.category = .sport
        tapRecognizer2.recipientName = self.selectedRecipientName
        secondImgView.addGestureRecognizer(tapRecognizer2)

        let thirdImg = UIImage(named: "beauty")
        let thirdImgView = UIImageView(image: thirdImg)
        thirdImgView.isUserInteractionEnabled = true
        thirdImgView.contentMode = .scaleAspectFit
        thirdImgView.clipsToBounds = true
        thirdImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer3 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer3.category = .other
        tapRecognizer3.recipientName = self.selectedRecipientName
        thirdImgView.addGestureRecognizer(tapRecognizer3)

        let stack = generateEvenContainerView(subViews: [firstImgView, secondImgView, thirdImgView], x: 20, y: currentHeight, width: frameWidth! - 40, height: 120, verticleSpacing: 0, horizontalSpacing: 0, sender: self)

        return stack
    }
    
    @objc func pushCategoryVC(sender: CategoryTappedGestureRecognizer) {
        let vc = CategoryViewController()
        vc.recipientName = self.selectedRecipientName
        vc.category = sender.category
        vc.merchants = []
        for merchant in allMerchants {
            if merchant.category == sender.category {
                vc.merchants!.append(merchant)
            }
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    /* - MARK: End Generate Category */
        
    func generateRecommendation(imgName: String, merchantName: String, merchantCategory: MerchantCaterogy, merchantHour: String) -> UIView {
        let container = generateUnevenContainerView(left: generateRecommendImage(name: "tfl"), right: generateRecommendLabel(name: merchantName, category: merchantCategory), ratio: 0.4, x: 30, y: currentHeight, width: frameWidth! - 60, height: 100, spacing: spacer, sender: self)
        container.isUserInteractionEnabled = true
        let tapRecognizer = MerchantTappedGestureRecognizer(target: self, action: #selector(segueToMerchantPage(sender:)))
        tapRecognizer.merchant = merchantLookUp(merchantName: merchantName)
        tapRecognizer.recipientName = self.selectedRecipientName
        container.addGestureRecognizer(tapRecognizer)
        return container
    }
    
    @objc func segueToMerchantPage(sender: MerchantTappedGestureRecognizer) {
        let vc = MerchantPageViewController()
        vc.merchant = sender.merchant
        vc.selectedRecipientName = sender.recipientName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func generateRecommendImage(name: String) -> UIImageView {
        let img = UIImage(named: name)
        let imgView = UIImageView()
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        return imgView
    }
    
    func generateRecommendLabel(name: String, category: MerchantCaterogy) -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.backgroundColor = visaBlue
        
        let categoryLabel = UILabel()
        categoryLabel.backgroundColor = visaBlue
        categoryLabel.textColor = visaOrange
        categoryLabel.text = "   " + categoryToString[category]!
        categoryLabel.font = UIFont(name: categoryLabel.font.fontName, size: 15)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.backgroundColor = visaBlue
        nameLabel.textColor = .white
        nameLabel.text = "  " + name
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let separateLabel = UILabel()
        separateLabel.backgroundColor = visaBlue
        separateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let visitedLabel = UILabel()
        visitedLabel.backgroundColor = visaBlue
        visitedLabel.textColor = visaOrange
        visitedLabel.text = "   2 friend visited"
        visitedLabel.font = UIFont(name: visitedLabel.font.fontName, size: 11)
        visitedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(categoryLabel)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(separateLabel)
        stack.addArrangedSubview(visitedLabel)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    
    /* - MARK: UI helper functions */
    
    func generateSectionHeaderLabel(text: String) -> UILabel {
        let frame = CGRect(x: 30, y: currentHeight, width: 200, height: 50)
        let label = UILabel(frame: frame)
        label.text = text
        label.backgroundColor = .white
        label.textColor = .darkGray
        label.font = UIFont(name: label.font.fontName, size: 23)
        currentHeight += 50
        return label
    }
    
    func generateViewMoreButton(text: String) -> UIButton {
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
        let btn = UIButton(frame: frame)
        let attributedText = NSAttributedString(string: text, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
        btn.setAttributedTitle(attributedText, for: .normal)
        btn.setTitleColor(visaBlue, for: .normal)
        btn.contentHorizontalAlignment = .center
        btn.backgroundColor = .white
        currentHeight += 50
        return btn
    }
    
    func incrementBySpacer(h: CGFloat) {
        currentHeight += h
    }
    
    func generateStoryView() -> StoryView {
        let frame = CGRect(x: 30, y: currentHeight, width: frameWidth!, height: 100)
        let storyView = StoryView(frame: frame)
        storyView.delegate = self
        storyView.dataSource = self
        currentHeight += 100 + spacer * 2
        return storyView
    }
    
    func storyView(_ storyView: StoryView, tappedCellAt item: Int) {
        return
    }
    
    func storyView(_ storyView: StoryView, longPressedCellAt item: Int) {
        return
    }
    
    func numberOfItems(in storyView: StoryView) -> Int {
        return 5
    }
    
    func storyView(_ storyView: StoryView, storyForItem item: Int) -> Story {
        let img = UIImage(named: "tfl2")!
        let story = Story(image: img, title: "The Fench Laundry", color: visaBlue, borderWidth: 1.5)
        return story
    }

}
