//
//  GiftSendingViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class GiftSendingViewController: UIViewController {
    /* - MARK: Data input */
    var userName: String? = nil
    var recipientName: String? = nil
    var merchantName: String? = nil
    
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
        scrollView.addSubview(generateVisaImage())
        scrollView.addSubview(generateMiddleTitle(text: "Sending a $10.00 Gift to", font: 20, color: visaBlue))
        scrollView.addSubview(generateMiddleTitle(text: "Kevin the Minion", font: 22, color: visaOrange))
        currentHeight += spacer
        scrollView.addSubview(generateSendingPictures())
        scrollView.addSubview(generateMiddleTitle(text: "To spend @", font: 14, color: visaBlue))
        scrollView.addSubview(generateMerchantPicture())
        scrollView.addSubview(generateMiddleTitle(text: "Blue Angel Cafe", font: 20, color: visaBlue))
        currentHeight += spacer
        scrollView.addSubview(generateMiddleTitle(text: "Thank you for your support to local merchants!", font: 12, color: visaOrange))
        scrollView.addSubview(generateConfirmButton())
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
    }
    
    
    func generateMiddleTitle(text: String, font: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: font)
        label.textColor = color
        label.textAlignment = .center
        label.numberOfLines = 1
        label.frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
        currentHeight += 50
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
        imgView3.contentMode = .scaleAspectFit
        imgView3.clipsToBounds = true
        imgView3.layer.cornerRadius = 35
        imgView3.layer.borderColor = visaOrange.cgColor
        imgView3.layer.borderWidth = 1.5
        imgView3.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        
        return generateEvenContainerView(subViews: [imgView, imgView2, imgView3], x: 20, y: currentHeight, width: frameWidth! - 40, height: 80, verticleSpacing: 0, horizontalSpacing: 40)
    }
    
    func generateMerchantPicture() -> UIImageView {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "tfl")
        imgView.frame = CGRect(x: (frameWidth! - 100) / 2, y: currentHeight, width: 100, height: 100)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 35
        imgView.layer.borderColor = visaBlue.cgColor
        imgView.layer.borderWidth = 1.5
        currentHeight += 100
        return imgView
    }
    
    func generateConfirmButton() -> UIButton {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: currentHeight, width: frameWidth! - 40, height: 50)
        button.setTitle("CONFIRM & SEND GIFT", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = visaBlue
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(GiftSendingViewController.confirmButtonTapped), for: .touchUpInside)
        return button
    }
    
    @objc func confirmButtonTapped() {
        self.navigationController?.pushViewController(GiftSentViewController(), animated: true)
    }
    
    /* - MARK: Some helper functions */
        // This function generate uneven container view, UPDATING currentHeight in the end
    
    func generateVisaImage() -> UIImageView {
        let img = UIImage(named: "visa")
        let imgView = UIImageView(image: img)
        imgView.frame = CGRect(x: frameWidth! - 130, y: currentHeight, width: 80, height: 70)
        currentHeight += 70
        return imgView
    }
    
        func generateUnevenContainerView(left: UIView, right: UIView, ratio: CGFloat, x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat, spacing: CGFloat) -> UIView {
            let frame = CGRect(x: x, y: y, width: width, height: height)
            let container = UIView(frame: frame)
    //        container.backgroundColor = visaBlue
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
        
        func generateNameCard(imgName: String, text1: String, text2: String, text3: String, font1: CGFloat, font2: CGFloat, font3: CGFloat, labelName: String, x: CGFloat, y: CGFloat) -> UIView {
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
            
            let secondView =  generateUnevenContainerView(left: stack, right: rightLabel, ratio: 0.7, x: x + 100, y: y, width: frameWidth! - 130 - x, height: 100, spacing: 0)
            
            let frame = CGRect(x: x, y: y, width: frameWidth! - x - 30, height: 100)
            let container = UIView(frame: frame)
            container.backgroundColor = .white
            
            container.addSubview(imgView)
            container.addSubview(secondView)
            imgView.frame = CGRect(x: 15, y: 15, width: 70, height: 70)
            secondView.frame = CGRect(x: 100, y: 0, width: frameWidth! - 60, height: 100)
            
            currentHeight += spacer
            
            return container
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
