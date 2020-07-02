//
//  SelectAmountViewController.swift
//  beta-link-frontend
//
//  Created by 徐乾智 on 6/29/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class SelectAmountViewController: UIViewController, CustomVC {
    
    /* - MARK: Data input */
    var userName: String?
    var recipient: Friend?
    var merchant: Merchant?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 90
    var frameWidth: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frameWidth = self.view.frame.width
        self.view.backgroundColor = .white

        self.view.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        currentHeight += spacer * 3
        for i in stride(from: 5, through: 25, by: 10) {
            self.view.addSubview(generateAmountLabel(amount1: i, amount2: i + 5))
        }
        
        // Do any additional setup after loading the view.
    }
    
    func generateAmountLabel(amount1: Int, amount2: Int) -> UIView {
        let label = UILabel()
        label.text = "$" + String(amount1)
        label.backgroundColor = visaBlue
        label.textAlignment = .center
        label.textColor = visaOrange
        label.font = UIFont.boldSystemFont(ofSize: 55)
        label.isUserInteractionEnabled = true
        let tapRecognizer = MerchantTappedGestureRecognizer(target: self, action: #selector(SelectAmountViewController.pushSendingPageVC(sender:)))
        tapRecognizer.merchant = self.merchant
        tapRecognizer.recipient = self.recipient
        tapRecognizer.amountSelected = amount1
        label.addGestureRecognizer(tapRecognizer)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let label2 = UILabel()
        label2.text = "$" + String(amount2)
        label2.backgroundColor = visaBlue
        label2.textAlignment = .center
        label2.textColor = visaOrange
        label2.font = UIFont.boldSystemFont(ofSize: 55)
        label2.isUserInteractionEnabled = true
        let tapRecognizer2 = MerchantTappedGestureRecognizer(target: self, action: #selector(SelectAmountViewController.pushSendingPageVC(sender:)))
        tapRecognizer2.merchant = self.merchant
        tapRecognizer2.recipient = self.recipient
        tapRecognizer2.amountSelected = amount2
        label2.addGestureRecognizer(tapRecognizer2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        let container = generateEvenContainerView(subViews: [label, label2], x: 20, y: currentHeight, width: frameWidth! - 40, height: 140, verticleSpacing: 10, horizontalSpacing: 30, sender: self)
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        
        currentHeight += spacer * 3
        
        return container
    }
    
    @objc func pushSendingPageVC(sender: MerchantTappedGestureRecognizer) {
        let vc = GiftSendingViewController()
        vc.merchant = sender.merchant
        vc.recipient = sender.recipient
        vc.amountSelected = sender.amountSelected
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /* - MARK: UI helper functions */
    
    func incrementBySpacer(h: CGFloat) {
        currentHeight += h
    }
}
