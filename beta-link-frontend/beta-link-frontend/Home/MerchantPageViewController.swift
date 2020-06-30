//
//  MerchantPageViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class MerchantPageViewController: UIViewController, CustomVC {
    
    /* - MARK: Data input */
    var userName: String? = nil
    var selectedRecipientName: String?
    
    var merchant: Merchant?
    var merchantWeekendHour: String? = "Hours: Sat - Sun, 11:00AM - 5:00PM"
    

    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 85
    var frameWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        self.view.backgroundColor = .white
        self.view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        
        self.view.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        currentHeight += spacer
        self.view.addSubview(generateSectionHeaderLabel(text: self.merchant!.name))
        self.view.addSubview(generateMerchantPicture(pictureName: "tfl"))
        currentHeight += spacer
        self.view.addSubview(generateNumGifted())
        self.view.addSubview(generateMerchantInfo(category: categoryToString[self.merchant!.category]!, hour: "Hours: Sat - Sun, 11:00AM - 5:00PM", address: self.merchant!.address + self.merchant!.city))
        self.view.addSubview(generateButtons())
    }
    
    func generateMerchantPicture(pictureName: String) -> UIImageView {
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: frameWidth! - 60)
        let imgView = UIImageView(frame: frame)
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: pictureName)
        
        currentHeight += frameWidth! - 60
        return imgView
    }
    
    func generateNumGifted() -> UIImageView {
        let frame = CGRect(x: 240, y: currentHeight, width: frameWidth! - 240, height: 100)
        let imgView = UIImageView(frame: frame)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "num_purchased")
        return imgView
    }
    
    func generateMerchantInfo(category: String, hour: String, address: String) -> UIView {
        let label1 = UILabel()
        label1.text = category
        label1.font = UIFont.systemFont(ofSize: 18)
        label1.textColor =  visaOrange
        
        let label2 = UILabel()
        label2.text = hour
        label2.font = UIFont.systemFont(ofSize: 15)
        label2.textColor =  .black
        label2.numberOfLines = 2
        
        let label3 = UILabel()
        label3.text = hour
        label3.font = UIFont.systemFont(ofSize: 15)
        label3.textColor =  .black
        label3.numberOfLines = 2
        
        let label4 = UILabel()
        label4.text = address
        label4.font = UIFont.systemFont(ofSize: 17)
        label4.textColor = .darkGray
        label4.numberOfLines = 2
        
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.backgroundColor = .white
        stack.axis = .vertical
        stack.addArrangedSubview(label1)
        stack.addArrangedSubview(label2)
        stack.addArrangedSubview(label3)
        stack.addArrangedSubview(label4)
//        stack.translatesAutoresizingMaskIntoConstraints = false
        
        stack.frame = CGRect(x: 20, y: currentHeight, width: 220, height: 100)
        currentHeight += 100 + spacer * 2
        return stack
    }
    
    
    func generateButtons() -> UIView {
        let button1 = CustomButton()
        button1.setImage(UIImage(named: "send_a_gift"), for: .normal)
        button1.backgroundColor = .white
        button1.merchant = self.merchant
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.addTarget(self, action: #selector(MerchantPageViewController.sendGiftButtonPressed(sender:)), for: .touchUpInside)
        
        let button2 = CustomButton()
        button2.setImage(UIImage(named: "leadership_board"), for: .normal)
        button2.backgroundColor = .white
        button2.merchant = self.merchant
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(MerchantPageViewController.leadershipButtonPressed(sender:)), for: .touchUpInside)
        
        let view = generateEvenContainerView(subViews: [button1, button2], x: 10, y: currentHeight, width: frameWidth! - 20, height: 85, verticleSpacing: spacer, horizontalSpacing: 20, sender: self)
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    @objc func sendGiftButtonPressed(sender: CustomButton!) {
        if (selectedRecipientName == nil) {
            let vc = FriendListViewController()
            vc.selectedMerchant = self.merchant
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SelectAmountViewController()
            vc.recipientName = self.selectedRecipientName
            vc.merchant = self.merchant
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @objc func leadershipButtonPressed(sender: CustomButton!) {
        let vc = LeadershipBoardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func generateSectionHeaderLabel(text: String) -> UILabel {
        let frame = CGRect(x: 30, y: currentHeight, width: 200, height: 40)
        let label = UILabel(frame: frame)
        label.text = text
        label.backgroundColor = .white
        label.textColor = visaBlue
        label.font = UIFont.boldSystemFont(ofSize: 23)
        currentHeight += 40
        return label
    }
    
    func incrementBySpacer(h: CGFloat) {
        currentHeight += h
    }

}
