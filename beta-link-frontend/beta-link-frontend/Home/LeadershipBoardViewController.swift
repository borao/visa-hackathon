//
//  LeadershipBoardViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class LeadershipBoardViewController: UIViewController, CustomVC {
    
    /* - MARK: Data input */
    var merchant: Merchant?
    
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
//        scrollView.addSubview(generateSectionHeaderLabel(text: "Blue Angel Cafe"))
        scrollView.addSubview(generateMerchantPicture(pictureName: "tfl", merchantName: "Blue Angel Cafe"))
        scrollView.addSubview(generateLeadershipTitlePicture())
        for i in (0...2) {
            scrollView.addSubview(generateNameCard(imgName: "minion", text1: "Carl the Minion", text2: "@carlminion", text3: "", font1: 20, font2: 14, font3: 1, labelName: "#" + String(i + 1), x: 10, y: currentHeight, sender: self))
        }
        scrollView.addSubview(generateViewMoreButton(text: "View Full Leadership Board"))
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
        
        
        // Do any additional setup after loading the view.
    }
    
    func generateMerchantPicture(pictureName: String, merchantName: String) -> UIImageView {
            let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: frameWidth! - 30)
            let imgView = UIImageView(frame: frame)
            imgView.contentMode = .scaleToFill
            imgView.clipsToBounds = true
            imgView.image = UIImage(named: pictureName)
            
            currentHeight += frameWidth! - 30
            return imgView
    }
    
    func generateLeadershipTitlePicture() -> UIImageView {
            let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 75)
            let imgView = UIImageView(frame: frame)
            imgView.contentMode = .scaleToFill
            imgView.clipsToBounds = true
            imgView.image = UIImage(named: "leaderboard_title")
            
            currentHeight += 70 + spacer
            return imgView
    }
    
        
    /* - MARK: UI helper functions */
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
