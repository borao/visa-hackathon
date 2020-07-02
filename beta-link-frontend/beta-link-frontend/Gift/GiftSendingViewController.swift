//
//  GiftSendingViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class GiftSendingViewController: UIViewController, CustomVC {
    /* - MARK: Data input */
    var userName: String? = nil
    var recipient: Friend?
    var merchant: Merchant?
    var amountSelected: Int?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 0
    var frameWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isUserInteractionEnabled = true
        
        self.view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        // Do any additional setup after loading the view.
        scrollView.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        currentHeight += spacer
        scrollView.addSubview(generateMiddleTitle(text: "Sending a $" + String(self.amountSelected!) + ".00 Gift to", font: 22, color: visaBlue, numOfLine: 1, height: 40))
        scrollView.addSubview(generateMiddleTitle(text: recipient!.name, font: 24, color: visaOrange, numOfLine: 1, height: 40))
        currentHeight += spacer * 0.5
        scrollView.addSubview(generateSendingPictures())
        scrollView.addSubview(generateMiddleTitle(text: "To spend @", font: 14, color: visaBlue, numOfLine: 1, height: 50))
        scrollView.addSubview(generateMerchantPicture())
        scrollView.addSubview(generateMiddleTitle(text: self.merchant!.name, font: 20, color: visaBlue, numOfLine: 1, height: 40))
        currentHeight += spacer * 2
        scrollView.addSubview(generateThankPicture())
//        scrollView.addSubview(generateMiddleTitle(text: "Thank you for your support to local merchants!", font: 14, color: visaOrange, numOfLine: 1, height: 30))
//        scrollView.addSubview(generateMiddleTitle(text: "  NOTE: If receiver does not make a purchase within 7 days, entire amount will be refunded. If receiver does not spend all $10.00, the rest will be donated to the merchant to support smaller merchants.", font: 14, color: skyBlue, numOfLine: 4, height: 90))
        scrollView.addSubview(generateConfirmButton())
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
    }
    
    
    func generateMiddleTitle(text: String, font: CGFloat, color: UIColor, numOfLine: Int, height: CGFloat) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = color
        label.textAlignment = .center
        label.numberOfLines = numOfLine
        label.frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: height)
        currentHeight += height
        return label
    }
    
    func generateSendingPictures() -> UIView{
        let imgView = UIImageView()
        imgView.image = UIImage(named: "redeemed")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 35
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        let imgView2 = UIImageView()
        imgView2.image = UIImage(named: "sent")
        imgView2.contentMode = .scaleAspectFit
        imgView2.clipsToBounds = true
        imgView2.layer.cornerRadius = 35
        imgView2.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        let imgView3 = UIImageView()
        imgView3.image = UIImage(named: "minion")
        let separator: Character = "."
        let tokens = self.recipient!.picturePath.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
        if (tokens.count >= 2) {
            if let path = Bundle.main.path(forResource: String(tokens[0]), ofType: String(tokens[1])) {
                imgView3.image = UIImage(contentsOfFile: path)
            }
        }
        imgView3.contentMode = .scaleAspectFit
        imgView3.clipsToBounds = true
        imgView3.layer.cornerRadius = 35
        imgView3.layer.borderColor = visaOrange.cgColor
        imgView3.layer.borderWidth = 1.5
        imgView3.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        
        return generateEvenContainerView(subViews: [imgView, imgView2, imgView3], x: 20, y: currentHeight, width: frameWidth! - 40, height: 80, verticleSpacing: 0, horizontalSpacing: 40, sender: self)
    }
    
    func generateMerchantPicture() -> UIImageView {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "tfl")
        let separator: Character = "."
        let tokens = self.merchant!.picturePath.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
        if (tokens.count >= 2) {
            if let path = Bundle.main.path(forResource: String(tokens[0]), ofType: String(tokens[1])) {
                imgView.image = UIImage(contentsOfFile: path)
            }
        }
        imgView.frame = CGRect(x: (frameWidth! - 100) / 2, y: currentHeight, width: 100, height: 100)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 35
        imgView.layer.borderColor = visaBlue.cgColor
        imgView.layer.borderWidth = 1.5
        currentHeight += 100
        return imgView
    }
    
    func generateThankPicture() -> UIImageView {
        let imgView = UIImageView()
        imgView.frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 300)
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        imgView.image = UIImage(named: "warn")
        imgView.backgroundColor = .white
        currentHeight += 300
        return imgView
    }
    
    func generateConfirmButton() -> UIButton {
        let button = CustomButton()
        button.frame = CGRect(x: 20, y: currentHeight, width: frameWidth! - 40, height: 65)
        button.setImage(UIImage(named: "confirm_gift"), for: .normal)
        button.recipient = self.recipient
        button.amountSelected = self.amountSelected
        button.addTarget(self, action: #selector(GiftSendingViewController.confirmButtonTapped(sender:)), for: .touchUpInside)
        return button
    }
    
    @objc func confirmButtonTapped(sender: CustomButton) {
        let vc = GiftSentViewController()
        vc.amountSelected = self.amountSelected
        vc.recipient = sender.recipient
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /* - MARK: Some helper functions */
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
