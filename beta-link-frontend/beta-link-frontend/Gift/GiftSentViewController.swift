//
//  GiftSentViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/25/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class GiftSentViewController: UIViewController, CustomVC {
    /* - MARK: Data input */
    var recipientName: String?
    var amountSelected: Int?
    var merchant: Merchant?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 90
    var frameWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        self.view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        self.view.addSubview(generateSentPicture())
        self.view.addSubview(generateMiddleTitle(text: "Sent!", font: 28, color: visaBlue))
        self.view.addSubview(generateMiddleTitle(text: "Thank you for your support to local merchants!", font: 16, color: visaOrange))
        currentHeight += spacer * 3
        self.view.addSubview(generateNameCard(imgName: "minion", text1: recipientName!, text2: "will receive your gift!", text3: "", font1: 16, font2: 16, font3: 1, labelName: "", x: 20, y: currentHeight, sender: self))
        // Do any additional setup after loading the view.
    }
    
    func generateMiddleTitle(text: String, font: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.boldSystemFont(ofSize: font)
        label.textColor = color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
        currentHeight += 50
        return label
    }
    
    func generateSentPicture() -> UIImageView {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "redeemed")
        imgView.frame = CGRect(x: (frameWidth! - 180) / 2 - 30, y: currentHeight, width: 180, height: 180)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        currentHeight += 180
        
        return imgView
    }
    
    
    /* - MARK: Some helper functions */
    
    func incrementBySpacer(h: CGFloat) {
        currentHeight += h
    }

}
