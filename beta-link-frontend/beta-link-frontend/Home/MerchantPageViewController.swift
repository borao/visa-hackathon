//
//  MerchantPageViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class MerchantPageViewController: UIViewController {
    
    /* - MARK: Data input */
    var userName: String? = nil
    var selectedFriend: String? = nil
    
    var merchantName: String? = "Blue Angel Cafe"
    var merchantCategory: String? = "Coffee & Tea"
    var merchantWeekdayHour: String? = "Hours: Mon - Fri, 10:00AM - 7:00PM"
    var merchantWeekendHour: String? = "Hours: Sat - Sun, 11:00AM - 5:00PM"
    var merchantAddress: String? = "2700 Hearst Ave, Berkeley, CA, 94608"
    

    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 100
    var frameWidth: CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        self.view.backgroundColor = .white
        self.view.isUserInteractionEnabled = true
        // Do any additional setup after loading the view.
        
        self.view.addSubview(generateSectionHeaderLabel(text: "Blue Angel Cafe"))
        self.view.addSubview(generateMerchantPicture(pictureName: "tfl", merchantName: "Blue Angel Cafe"))
        self.view.addSubview(generateMerchantInfo(name: "Blue Angle Cafe", hour: "Hours: Mon - Fri, 10:00AM - 7:00PM", address: "2700 Hearst Ave, Berkeley, CA, 94608"))
        self.view.addSubview(generateButtons())
    }
    
    func generateMerchantPicture(pictureName: String, merchantName: String) -> UIImageView {
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: frameWidth! - 50)
        let imgView = UIImageView(frame: frame)
        imgView.contentMode = .scaleToFill
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: pictureName)
        
        currentHeight += frameWidth! - 50 + spacer * 2
        return imgView
    }
    
    func generateMerchantInfo(name: String, hour: String, address: String) -> UIView {
        let label1 = UILabel()
        label1.text = name
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
        label4.font = UIFont.systemFont(ofSize: 18)
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
        
        stack.frame = CGRect(x: 10, y: currentHeight, width: frameWidth! - 10, height: 100)
        currentHeight += 100 + spacer * 2
        return stack
    }
    
    func generateButtons() -> UIView {
        let button1 = UIButton()
        button1.setTitle("Send Gift", for: .normal)
        button1.setTitleColor(.white, for: .normal)
        button1.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button1.contentHorizontalAlignment = .center
        button1.backgroundColor = visaBlue
        button1.translatesAutoresizingMaskIntoConstraints = false
        button1.addTarget(self, action: #selector(MerchantPageViewController.sendGiftButtonPressed(sender:)), for: .touchUpInside)
        
        let button2 = UIButton()
        button2.setTitle("Leadership\nBoard", for: .normal)
        button2.setTitleColor(.white, for: .normal)
        button2.titleLabel?.font = UIFont.systemFont(ofSize: 23)
        button2.contentHorizontalAlignment = .center
        button2.backgroundColor = visaBlue
        button2.titleLabel?.numberOfLines = 2
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.addTarget(self, action: #selector(MerchantPageViewController.leadershipButtonPressed(sender:)), for: .touchUpInside)
        
        let view = generateEvenContainerView(subViews: [button1, button2], x: 10, y: currentHeight, width: frameWidth! - 20, height: 70, verticleSpacing: spacer, horizontalSpacing: 20)
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        
        return view
    }
    
    @objc func leadershipButtonPressed(sender: UIButton!) {
        self.navigationController?.pushViewController(LeadershipBoardViewController(), animated: true)
    }
    
    @objc func sendGiftButtonPressed(sender: UIButton!) {
        self.navigationController?.pushViewController(GiftSendingViewController(), animated: true)
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
    
    
    
    /* - MARK: Model */

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
