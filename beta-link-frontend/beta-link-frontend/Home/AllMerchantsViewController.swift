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

class AllMerchantsViewController: UIViewController, UISearchBarDelegate, UIScrollViewDelegate, CustomVC {
    /* - MARK: Data input */
    var selectedRecipient: Friend?
    
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
        currentHeight += 50 + spacer
        scrollView.addSubview(generateSectionHeaderLabel(text: "All Merchants"))
        for merchant in allMerchants {
            let name = merchant.name
            let category = merchant.category
            let hour = "Hours: Sat - Sun, 11:00AM - 5:00PM"
            let path = merchant.picturePath
            scrollView.addSubview(generateRecommendation(imgName: path, merchantName: name, merchantCategory: category, merchantHour: hour))
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
        
    func generateRecommendation(imgName: String, merchantName: String, merchantCategory: MerchantCaterogy, merchantHour: String) -> UIView {
        let container = generateUnevenContainerView(left: generateRecommendImage(name: imgName), right: generateRecommendLabel(name: merchantName, category: merchantCategory), ratio: 0.4, x: 30, y: currentHeight, width: frameWidth! - 60, height: 100, spacing: spacer, sender: self)
        container.isUserInteractionEnabled = true
        let tapRecognizer = MerchantTappedGestureRecognizer(target: self, action: #selector(segueToMerchantPage(sender:)))
        tapRecognizer.merchant = merchantLookUp(merchantName: merchantName)
        tapRecognizer.recipient = self.selectedRecipient
        container.addGestureRecognizer(tapRecognizer)
        return container
    }
    
    @objc func segueToMerchantPage(sender: MerchantTappedGestureRecognizer) {
        let vc = MerchantPageViewController()
        vc.merchant = sender.merchant
        vc.selectedRecipient = sender.recipient
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func generateRecommendImage(name: String) -> UIImageView {
        let separator: Character = "."
        let tokens = name.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
        var img = UIImage(named: "tfl")
        if (tokens.count >= 2) {
            if let path = Bundle.main.path(forResource: String(tokens[0]), ofType: String(tokens[1])) {
                img = UIImage(contentsOfFile: path)
            }
        }
        let imgView = UIImageView()
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
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

}