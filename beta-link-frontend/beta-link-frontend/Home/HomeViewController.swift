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

class HomeViewController: UIViewController, UISearchBarDelegate, StoryViewDelegate, StoryViewDataSource {
    /* - MARK: Data input */
    var selectedRecipientName: String?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 0
    var frameWidth: CGFloat?
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        frameWidth = self.view.frame.width
        let scrollView = UIScrollView()
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

        scrollView.addSubview(generateVisaImage())
        scrollView.addSubview(generateSearchBar())
        scrollView.addSubview(generateTopCategory())
        scrollView.addSubview(generateBottomCategory())
        scrollView.addSubview(generateSeparationLine())
        scrollView.addSubview(generateSectionHeaderLabel(text: "Your Favorites"))
        scrollView.addSubview(generateStoryView())
        scrollView.addSubview(generateSeparationLine())
        scrollView.addSubview(generateSectionHeaderLabel(text: "Recommendation"))
        for merchant in allMerchants {
            let name = merchant.name
            let category = merchant.category
            let hour = merchant.hour
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
        bar.delegate = self
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
        tapRecognizer.category = .coffee
        tapRecognizer.recipientName = self.selectedRecipientName
        firstImgView.addGestureRecognizer(tapRecognizer)

        let secondImg = UIImage(named: "fast_food")
        let secondImgView = UIImageView(image: secondImg)
        secondImgView.isUserInteractionEnabled = true
        secondImgView.contentMode = .scaleAspectFit
        secondImgView.clipsToBounds = true
        secondImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer2 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer2.category = .fastFood
        tapRecognizer2.recipientName = self.selectedRecipientName
        secondImgView.addGestureRecognizer(tapRecognizer2)

        let thirdImg = UIImage(named: "dessert")
        let thirdImgView = UIImageView(image: thirdImg)
        thirdImgView.isUserInteractionEnabled = true
        thirdImgView.contentMode = .scaleAspectFit
        thirdImgView.clipsToBounds = true
        thirdImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer3 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer3.category = .dessert
        thirdImgView.addGestureRecognizer(tapRecognizer3)
        
        let stack = generateEvenContainerView(subViews: [firstImgView, secondImgView, thirdImgView], x: 20, y: currentHeight, width: frameWidth! - 40, height: 120, verticleSpacing: 0, horizontalSpacing: 0)
        
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
        tapRecognizer.category = .clothing
        tapRecognizer.recipientName = self.selectedRecipientName
        firstImgView.addGestureRecognizer(tapRecognizer)

        let secondImg = UIImage(named: "grocery")
        let secondImgView = UIImageView(image: secondImg)
        secondImgView.isUserInteractionEnabled = true
        secondImgView.contentMode = .scaleAspectFit
        secondImgView.clipsToBounds = true
        secondImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer2 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer2.category = .grocery
        tapRecognizer2.recipientName = self.selectedRecipientName
        secondImgView.addGestureRecognizer(tapRecognizer2)

        let thirdImg = UIImage(named: "beauty")
        let thirdImgView = UIImageView(image: thirdImg)
        thirdImgView.isUserInteractionEnabled = true
        thirdImgView.contentMode = .scaleAspectFit
        thirdImgView.clipsToBounds = true
        thirdImgView.translatesAutoresizingMaskIntoConstraints = false
        let tapRecognizer3 = CategoryTappedGestureRecognizer(target: self, action: #selector(HomeViewController.pushCategoryVC(sender:)))
        tapRecognizer3.category = .beauty
        tapRecognizer3.recipientName = self.selectedRecipientName
        thirdImgView.addGestureRecognizer(tapRecognizer3)

        let stack = generateEvenContainerView(subViews: [firstImgView, secondImgView, thirdImgView], x: 20, y: currentHeight, width: frameWidth! - 40, height: 120, verticleSpacing: 0, horizontalSpacing: 0)

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
        
    func generateRecommendation(imgName: String, merchantName: String, merchantCategory: MerchantCaterogy, merchantHour: String) -> UIView {
        let container = generateUnevenContainerView(left: generateRecommendImage(name: "tfl"), right: generateRecommendLabel(name: merchantName, category: merchantCategory), ratio: 0.4, x: 30, y: currentHeight, width: frameWidth! - 60, height: 100, spacing: spacer)
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
    // This function generate uneven container view, UPDATING currentHeight in the end
    func generateVisaImage() -> UIImageView {
        let img = UIImage(named: "visa")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
        currentHeight += 50
        return imgView
    }
    
    func generateUnevenContainerView(left: UIView, right: UIView, ratio: CGFloat, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, spacing: CGFloat) -> UIView {
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let container = UIView(frame: frame)
        container.backgroundColor = visaBlue
        container.clipsToBounds = true // this will make sure its children do not go out of the boundary
        
        container.addSubview(left)
        container.addSubview(right)

        left.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        left.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        left.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        left.widthAnchor.constraint(equalToConstant: width * ratio).isActive = true

        right.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        right.leadingAnchor.constraint(equalTo: left.trailingAnchor).isActive = true
        right.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        right.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        
        currentHeight += height + spacing

        return container
    }
    
    // Generate Evenly distributed container view
    func generateEvenContainerView(subViews: [UIView], x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, verticleSpacing: CGFloat, horizontalSpacing: CGFloat) -> UIView {
        let frame = CGRect(x: x, y: y, width: width, height: height)
        let container = UIView(frame: frame)
        container.clipsToBounds = true // this will make sure its children do not go out of the boundary
        
        for v in subViews {
            container.addSubview(v)
        }
        
        let numElem: CGFloat = CGFloat(subViews.count)
        let eachWidth: CGFloat = (width - horizontalSpacing * (numElem - 1)) / numElem
        
        for i in 0..<subViews.count {
            let elem = subViews[i]
            elem.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
            elem.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
            
            if (i == 0) {
                elem.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
            } else {
                elem.leadingAnchor.constraint(equalTo: subViews[i - 1].trailingAnchor, constant: horizontalSpacing).isActive = true
            }
            
            if (i == subViews.count - 1) {
                elem.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
            } else {
                elem.widthAnchor.constraint(equalToConstant: eachWidth).isActive = true
            }
        }
        
        currentHeight += height + verticleSpacing
        
        return container
    }
    
    func generateSeparationLine() -> UILabel {
        let color = visaBlue
        let frame = CGRect(x: 100, y: currentHeight, width: frameWidth! - 200, height: 3)
        let label = UILabel(frame: frame)
        label.backgroundColor = color
        currentHeight += 5 + spacer
        return label
    }
    
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

}
