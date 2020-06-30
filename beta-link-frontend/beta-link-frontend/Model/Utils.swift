//
//  Data.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/23/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import Foundation
import UIKit

let spacer: CGFloat = 10
protocol CustomVC {
    var currentHeight: CGFloat { get set }
    var frameWidth: CGFloat? { get set }
    
    func incrementBySpacer(h: CGFloat)
}

class MerchantTappedGestureRecognizer: UITapGestureRecognizer {
    var merchant: Merchant?
    var recipientName: String?
    var amountSelected: Int?
}

class CategoryTappedGestureRecognizer: UITapGestureRecognizer {
    var recipientName: String?
    var category: MerchantCaterogy?
}

class CustomButton: UIButton {
    var merchant: Merchant?
    var recipientName: String?
    var amountSelected: Int?
}

enum MerchantCaterogy: Int {
    case food
    case clothing
    case grocery
    case beauty
    case sport
    case other
}

struct Merchant {
    var name: String
    var category: MerchantCaterogy
    var id: String
    var lon: Double
    var lat: Double
    var state: String
    var address: String
    var city: String
}

func merchantLookUp(merchantName: String) -> Merchant? {
    for merchant in allMerchants {
        if merchant.name == merchantName {
            return merchant
        }
    }
    return nil
}

let categoryToString = [MerchantCaterogy.food: "Food",
                        MerchantCaterogy.clothing: "Clothing",
                        MerchantCaterogy.grocery: "Grocery",
                        MerchantCaterogy.beauty: "Beauty",
                        MerchantCaterogy.sport: "Sport",
                        MerchantCaterogy.other: "More",]

let visaOrange = UIColor(rgb: 0xEF991A)
let visaBlue = UIColor(rgb: 0x0D158C)
let skyBlue = UIColor(rgb: 0x00CCFF)

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

// MARK: User Interface Helper

func generateVisaImage(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) -> UIImageView {
    let img = UIImage(named: "visa")
    let imgView = UIImageView(image: img)
    imgView.frame = CGRect(x: x, y: y, width: width, height: height)
    return imgView
}

func generateSeparationLine(sender: CustomVC) -> UILabel {
    let color = visaBlue
    let frame = CGRect(x: 100, y: sender.currentHeight, width: sender.frameWidth! - 200, height: 3)
    let label = UILabel(frame: frame)
    label.backgroundColor = color
    sender.incrementBySpacer(h: spacer + 5)
    return label
}

func generateUnevenContainerView(left: UIView, right: UIView, ratio: CGFloat, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, spacing: CGFloat, sender: CustomVC, color: UIColor = visaBlue) -> UIView {
    let frame = CGRect(x: x, y: y, width: width, height: height)
    let container = UIView(frame: frame)
    container.backgroundColor = color
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
    
    sender.incrementBySpacer(h: height + spacing)

    return container
}

func generateEvenContainerView(subViews: [UIView], x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, verticleSpacing: CGFloat, horizontalSpacing: CGFloat, sender: CustomVC) -> UIView {
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
    
    sender.incrementBySpacer(h: height + verticleSpacing)
    
    return container
}

func generateNameCard(imgName: String, text1: String, text2: String, text3: String, font1: CGFloat, font2: CGFloat, font3: CGFloat, labelName: String, x: CGFloat, y: CGFloat, sender: CustomVC, color: UIColor = .white) -> UIView {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFill
    imgView.layer.cornerRadius = 35
    imgView.layer.borderWidth = 1.5
    imgView.layer.borderColor = visaOrange.cgColor
    imgView.image = UIImage(named: imgName)
    imgView.clipsToBounds = true
    
    let label1 = UILabel()
    label1.text = text1
    label1.font = UIFont.systemFont(ofSize: font1)
    label1.textColor =  visaOrange
    
    let label2 = UILabel()
    label2.text = text2
    label2.font = UIFont.systemFont(ofSize: font2)
    label2.textColor =  visaBlue
    
    let label3 = UILabel()
    label3.text = text3
    label3.font = UIFont.systemFont(ofSize: font3)
    label3.textColor = .darkGray
    
    let stack = UIStackView()
    stack.distribution = .fillEqually
    stack.backgroundColor = .white
    stack.axis = .vertical
    stack.addArrangedSubview(label1)
    stack.addArrangedSubview(label2)
    stack.addArrangedSubview(label3)
    stack.translatesAutoresizingMaskIntoConstraints = false
    
    let rightLabel = UILabel()
    rightLabel.text = labelName
    rightLabel.font = UIFont.systemFont(ofSize: 30)
    rightLabel.textColor = visaOrange
    rightLabel.backgroundColor = .white
    rightLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let secondView =  generateUnevenContainerView(left: stack, right: rightLabel, ratio: 0.7, x: x + 100, y: y, width: sender.frameWidth! - 130 - x, height: 100, spacing: 0, sender: sender, color: color)
    
    let frame = CGRect(x: x, y: y, width: sender.frameWidth! - x - 30, height: 100)
    let container = UIView(frame: frame)
    container.backgroundColor = .white
    
    container.addSubview(imgView)
    container.addSubview(secondView)
    imgView.frame = CGRect(x: 15, y: 15, width: 70, height: 70)
    secondView.frame = CGRect(x: 100, y: 0, width: sender.frameWidth! - 60, height: 100)
    
    sender.incrementBySpacer(h: spacer)
    
    return container
}
