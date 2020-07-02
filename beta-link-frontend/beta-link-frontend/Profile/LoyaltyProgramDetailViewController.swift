////
////  MerchantPageViewController.swift
////  Beta Link
////
////  Created by 徐乾智 on 6/24/20.
////  Copyright © 2020 徐乾智. All rights reserved.
////
//
//import UIKit
//
//class LoyaltyProgramDetailViewController: UIViewController, CustomVC {
//
//    /* - MARK: Data input */
//    var merchant: Merchant?
//    var merchantWeekendHour: String = "Sat - Sun, 11:00AM - 5:00PM"
//
//    /* - MARK: User Interface */
//    let spacer: CGFloat = 10
//    var currentHeight: CGFloat = 85
//    var frameWidth: CGFloat?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        frameWidth = self.view.frame.width
//
//        var x: String = ""
//        var y: String = ""
//
//        print(programDetailDictionaries)
//
//        if programDetailDictionaries.keys.contains(self.merchant!.id) {
//            var lst = programDetailDictionaries[self.merchant!.id]!
//            print(lst)
//            for dict in lst {
//                guard let description = dict!["programID_id__description"] as? String else { continue }
////                guard let name = dict!["programID_id__programName"] as? String else { continue }
//                x = "Status & Reward"
//                y = description
//            }
//        }
//
//        self.view.backgroundColor = .white
//        self.view.isUserInteractionEnabled = true
//        // Do any additional setup after loading the view.
//
//        self.view.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
//        currentHeight += 50 + spacer
//        self.view.addSubview(generateSectionHeaderLabel(text: self.merchant!.name))
//        self.view.addSubview(generateMerchantPicture(pictureName: "tfl"))
//        currentHeight += spacer
////
//        self.view.addSubview(generateMerchantInfo(category: x, hour: y))
//    }
//
//    func generateMerchantPicture(pictureName: String) -> UIImageView {
////        let pathIn: String = "media/merchantLogo/JAMBA JUICE.jpg"
//        let pathIn: String = self.merchant!.picturePath
//        let separator: Character = "."
//        let tokens = pathIn.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
//        var img = UIImage(named: pictureName)
//        if (tokens.count >= 2) {
//            if let path = Bundle.main.path(forResource: String(tokens[0]), ofType: String(tokens[1])) {
//                img = UIImage(contentsOfFile: path)
//            }
//        }
//        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: frameWidth! - 60)
//        let imgView = UIImageView(frame: frame)
//        imgView.contentMode = .scaleToFill
//        imgView.clipsToBounds = true
//        imgView.image = img
//
//        currentHeight += frameWidth! - 60
//        return imgView
//    }
//
//    func generateNumGifted() -> UIImageView {
//        let frame = CGRect(x: 240, y: currentHeight, width: frameWidth! - 240, height: 100)
//        let imgView = UIImageView(frame: frame)
//        imgView.contentMode = .scaleAspectFit
//        imgView.clipsToBounds = true
//        imgView.image = UIImage(named: "3/10")
//        return imgView
//    }
//
//    func generateMerchantInfo(category: String, hour: String) -> UIView {
//        let label1 = UILabel()
//        label1.text = category
//        label1.font = UIFont.systemFont(ofSize: 20)
//        label1.textColor =  visaOrange
//
//        let label2 = UILabel()
//        label2.text = hour
//        label2.font = UIFont.systemFont(ofSize: 18)
//        label2.textColor = visaBlue
//
////        let label3 = UILabel()
////        label3.text = address1
////        label3.font = UIFont.systemFont(ofSize: 15)
////        label3.textColor =  .darkGray
////        label3.numberOfLines = 2
////
////        let label4 = UILabel()
////        label4.text = address2
////        label4.font = UIFont.systemFont(ofSize: 17)
////        label4.textColor = .darkGray
////        label4.numberOfLines = 2
//
//        let stack = UIStackView()
//        stack.distribution = .fillEqually
//        stack.backgroundColor = .black
//        stack.axis = .vertical
//        stack.addArrangedSubview(label1)
//        stack.addArrangedSubview(label2)
////        stack.addArrangedSubview(label3)
////        stack.addArrangedSubview(label4)
////        stack.translatesAutoresizingMaskIntoConstraints = false
//
//        stack.frame = CGRect(x: 20, y: currentHeight, width: 220, height: 100)
//        currentHeight += 100 + spacer * 2
//        return stack
//    }
//
//    func generateSectionHeaderLabel(text: String) -> UILabel {
//        let frame = CGRect(x: 30, y: currentHeight, width: 200, height: 40)
//        let label = UILabel(frame: frame)
//        label.text = text
//        label.backgroundColor = .white
//        label.textColor = visaBlue
//        label.font = UIFont.boldSystemFont(ofSize: 23)
//        currentHeight += 40
//        return label
//    }
//
//    func incrementBySpacer(h: CGFloat) {
//        currentHeight += h
//    }
//
//}
