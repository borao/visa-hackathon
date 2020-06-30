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

class ProfileViewController: UIViewController, CustomVC {
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
        
        scrollView.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        scrollView.addSubview(generateProfileContainerView())
        scrollView.addSubview(generateButtonContainer(pictureName: "star", text: "Loyalty Programs"))
        scrollView.addSubview(generateButtonContainer(pictureName: "friends", text: "View Friends   "))
        scrollView.addSubview(generateSeparationLine(sender: self))
        scrollView.addSubview(generateSectionHeaderLabel(text: "Manage Gifts"))
        scrollView.addSubview(generateManageGiftContainer())
        currentHeight += spacer
        scrollView.addSubview(generateSeparationLine(sender: self))
        scrollView.addSubview(generateSectionHeaderLabel(text: "Impact"))
        scrollView.addSubview(generateImpactContainer())
        scrollView.addSubview(generateSeparationLine(sender: self))
        scrollView.addSubview(generateSectionHeaderLabel(text: "Transaction History"))
        scrollView.addSubview(generateViewMoreButton(text: "View Transaction History"))
        scrollView.addSubview(generateGoogleSigninButton())
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
        // Do any additional setup after loading the view.
    }
    
    // Profile section
    func generateProfileContainerView() -> UIView {
        return generateNameCard(imgName: "minion", text1: "Bob the Minion", text2: "New York, NY", text3: "Level-5 user", font1: 22, font2: 14, font3: 14, labelName: "❤️", x: 20, y: currentHeight, sender: self)
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
        let container = generateUnevenContainerView(left: imgView, right: button, ratio: 0.1, x: 30, y: currentHeight, width: frameWidth! - 30, height: 34, spacing: 10, sender: self)
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
        
        let container = generateEvenContainerView(subViews: [imgView, imgView2, imgView3], x: 35, y: currentHeight, width: frameWidth! - 70, height: 100, verticleSpacing: 0, horizontalSpacing: 0, sender: self)
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
        
        let container = generateEvenContainerView(subViews: [stack, stack2, stack3, stack4], x: 20, y: currentHeight, width: frameWidth! - 40, height: 85, verticleSpacing: 20, horizontalSpacing: 20, sender: self)
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
    // Generate Evenly distributed container view
    
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
