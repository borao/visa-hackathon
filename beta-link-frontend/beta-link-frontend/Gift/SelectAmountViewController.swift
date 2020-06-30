//
//  SelectAmountViewController.swift
//  beta-link-frontend
//
//  Created by 徐乾智 on 6/29/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class SelectAmountViewController: UIViewController {
    
    /* - MARK: Data input */
    var userName: String?
    var recipientName: String?
    var merchant: Merchant?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 90
    var frameWidth: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        frameWidth = self.view.frame.width
        self.view.backgroundColor = .white
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = .white
//        scrollView.isUserInteractionEnabled = true
//
//        self.view.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
//        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
//        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
//        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true

        self.view.addSubview(generateVisaImage())
        currentHeight += spacer * 3
        for i in 1...3 {
            self.view.addSubview(generateAmountLabel(amount1: 5 * i, amount2: 10 * i))
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
        tapRecognizer.recipientName = self.recipientName
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
        tapRecognizer2.recipientName = self.recipientName
        tapRecognizer2.amountSelected = amount2
        label2.addGestureRecognizer(tapRecognizer2)
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        let container = generateEvenContainerView(subViews: [label, label2], x: 20, y: currentHeight, width: frameWidth! - 40, height: 140, verticleSpacing: 10, horizontalSpacing: 30)
        container.backgroundColor = .white
        container.isUserInteractionEnabled = true
        
        currentHeight += spacer * 3
        
        return container
    }
    
    @objc func pushSendingPageVC(sender: MerchantTappedGestureRecognizer) {
        let vc = GiftSendingViewController()
        vc.merchant = sender.merchant
        vc.recipientName = sender.recipientName
        vc.amountSelected = sender.amountSelected
        self.navigationController?.pushViewController(vc, animated: true)
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
}
