//
//  GiftSentViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/25/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class GiftSentViewController: UIViewController {
    /* - MARK: Data input */
    var recipientName: String? = nil
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 100
    var frameWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        self.view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.view.addSubview(generateVisaImage())
        self.view.addSubview(generateSentPicture())
        self.view.addSubview(generateMiddleTitle(text: "Sent!", font: 28, color: visaBlue))
        self.view.addSubview(generateMiddleTitle(text: "Thank you for your support to local merchants!", font: 14, color: visaOrange))
        currentHeight += spacer * 3
        self.view.addSubview(generateNameCard(imgName: "minion", text1: "Kevin the Minion", text2: "will receive your gift!", text3: "", font1: 16, font2: 16, font3: 1, labelName: "", x: 20, y: currentHeight))
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    func generateSentPicture() -> UIImageView {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "redeemed")
        imgView.frame = CGRect(x: (frameWidth! - 180) / 2, y: currentHeight, width: 180, height: 180)
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        currentHeight += 180
        
        return imgView
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
        
        return container
    }

}
