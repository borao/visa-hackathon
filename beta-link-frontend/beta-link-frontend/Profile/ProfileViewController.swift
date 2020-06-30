//
//  ProfileViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/22/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit
import StoryView
import GoogleSignIn

class ProfileViewController: UIViewController {
    /* - MARK: Data input */
    var userName: String? = nil
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 0
    var frameWidth: CGFloat?
    
    override func viewDidLoad() {
        frameWidth = self.view.frame.width
        super.viewDidLoad()
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isUserInteractionEnabled = true
        self.view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(generateVisaImage())
        scrollView.addSubview(generateProfileContainerView())
        scrollView.addSubview(generateButtonContainer(pictureName: "star", text: "Loyalty Programs"))
        scrollView.addSubview(generateButtonContainer(pictureName: "friends", text: "View Friends   "))
        scrollView.addSubview(generateSeparationLine())
        scrollView.addSubview(generateSectionHeaderLabel(text: "Manage Gifts"))
        scrollView.addSubview(generateManageGiftContainer())
        currentHeight += spacer
        scrollView.addSubview(generateSeparationLine())
        scrollView.addSubview(generateSectionHeaderLabel(text: "Impact"))
        scrollView.addSubview(generateImpactContainer())
        scrollView.addSubview(generateSeparationLine())
        scrollView.addSubview(generateSectionHeaderLabel(text: "Transaction History"))
        scrollView.addSubview(generateViewMoreButton(text: "View Transaction History"))
        scrollView.addSubview(generateGoogleSigninButton())
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
        // Do any additional setup after loading the view.
    }
    
    // Profile section
    func generateProfileContainerView() -> UIView {
        return generateNameCard(imgName: "minion", text1: "Bob the Minion", text2: "New York, NY", text3: "Level-5 user", font1: 22, font2: 14, font3: 14, labelName: "❤️", x: 20, y: currentHeight)
    }
    
    // Loyalty program + view friend button section
    func generateButtonContainer(pictureName: String, text: String) -> UIView {
        // make image
        let imgView = UIImageView()
        imgView.image = UIImage(named: pictureName)
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imgView.backgroundColor = visaBlue
        
        // make button
        let button = UIButton()
        button.setTitle("    " + text, for: .normal)
        button.setTitleColor(visaOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = visaBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // make container
        let container = generateUnevenContainerView(left: imgView, right: button, ratio: 0.1, x: 30, y: currentHeight, width: frameWidth! - 30, height: 34, spacing: 10)
        container.backgroundColor = visaBlue
        
        return container
        
    }
    
    // Manage gift section
    func generateManageGiftContainer() -> UIView {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "manage_sent")
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 10
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imgView.backgroundColor = .white
        
        let imgView2 = UIImageView()
        imgView2.image = UIImage(named: "manage_redeemed")
        imgView2.contentMode = .scaleAspectFit
        imgView2.clipsToBounds = true
        imgView2.layer.cornerRadius = 10
        imgView2.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imgView2.backgroundColor = .white
        
        let imgView3 = UIImageView()
        imgView3.image = UIImage(named: "manage_past_gift")
        imgView3.contentMode = .scaleAspectFit
        imgView3.clipsToBounds = true
        imgView3.layer.cornerRadius = 10
        imgView3.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imgView3.backgroundColor = .white
        
        let container = generateEvenContainerView(subViews: [imgView, imgView2, imgView3], x: 35, y: currentHeight, width: frameWidth! - 70, height: 100, verticleSpacing: 0, horizontalSpacing: 0)
        container.backgroundColor = .white
        
        return container
    }
    
    // Impact section
    func generateImpactLabel(topText: String, bottomText: String) -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.backgroundColor = visaBlue
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let topLabel = UILabel()
        topLabel.text = topText
        topLabel.backgroundColor = visaBlue
        topLabel.textColor = .white
        topLabel.textAlignment = .center
        topLabel.lineBreakMode = .byWordWrapping
        topLabel.numberOfLines = 2
        topLabel.font = UIFont(name: topLabel.font.fontName, size: 13)
        
        let bottomLabel = UILabel()
        bottomLabel.text = bottomText
        bottomLabel.backgroundColor = visaBlue
        bottomLabel.textColor = visaOrange
        bottomLabel.textAlignment = .center
        bottomLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        stack.addArrangedSubview(topLabel)
        stack.addArrangedSubview(bottomLabel)
        
        stack.layer.cornerRadius = 20
        
        return stack
    }
    
    func generateImpactContainer() -> UIView {
        let stack = generateImpactLabel(topText: "# of gift sent", bottomText: "7")
        let stack2 = generateImpactLabel(topText: "Total gift", bottomText: "$45")
        let stack3 = generateImpactLabel(topText: "Total impact", bottomText: "$105")
        let stack4 = generateImpactLabel(topText: "Total transactions", bottomText: "30")
        
        let container = generateEvenContainerView(subViews: [stack, stack2, stack3, stack4], x: 20, y: currentHeight, width: frameWidth! - 40, height: 85, verticleSpacing: 20, horizontalSpacing: 20)
        container.backgroundColor = .white
        
        return container
    }
    
    func generateGoogleSigninButton() -> GIDSignInButton {
        let button = GIDSignInButton(frame: CGRect(x: 40, y: currentHeight, width: frameWidth! - 80, height: 50))
        
        GIDSignIn.sharedInstance()?.presentingViewController = self

        // Automatically sign in the user.
        GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        
        currentHeight += 50
        
        return button
    }
    
/* - MARK: Some helper functions */
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
        let frame = CGRect(x: 30, y: currentHeight, width: frameWidth! - 30, height: 50)
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
