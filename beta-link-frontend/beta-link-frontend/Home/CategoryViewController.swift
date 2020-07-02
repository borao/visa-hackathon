//
//  CategoryViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit
import MapKit

class CategoryViewController: UIViewController, UIScrollViewDelegate, UISearchBarDelegate, CustomVC {
    /* - MARK: Data input */
    var category: MerchantCaterogy?
    var merchants: [Merchant]?
    var recipient: Friend?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 0
    var frameWidth: CGFloat?
    
    override func viewDidAppear(_ animated: Bool) {
        self.view.endEditing(true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isUserInteractionEnabled = true
        
        self.view.addSubview(scrollView)
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        scrollView.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
//        scrollView.addSubview(generateSearchBar())
        scrollView.addSubview(generateMap())
        scrollView.addSubview(generateSeparationLine(sender: self))
        for i in 0 ..< self.merchants!.count {
            scrollView.addSubview(generateRecommendation(imgName: self.merchants![i].picturePath, merchantName: self.merchants![i].name, merchantHour: "Hours: Sat - Sun, 11:00AM - 5:00PM"))
        }
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
        
        // Do any additional setup after loading the view.
    }
    func generateSearchBar() -> UISearchBar {
        let bar = UISearchBar()
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
        bar.frame = frame
        bar.barTintColor = visaBlue
        bar.searchTextField.backgroundColor = .white
        bar.resignFirstResponder()
        bar.isUserInteractionEnabled = true
        bar.delegate = self
        bar.becomeFirstResponder()
        currentHeight += 50 + spacer
        return bar
    }
    
    func generateMap() -> MKMapView {
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: frameWidth! - 30)
        let map = MKMapView(frame: frame)
        let initialLocation = CLLocation(latitude: self.merchants![0].lat, longitude: self.merchants![0].lon)
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 8000, longitudinalMeters: 8000)
        map.setRegion(initialRegion, animated: true)
        
        for merchant in self.merchants! {
            let annotation = MKPointAnnotation()
            let location = CLLocation(latitude: merchant.lat, longitude: merchant.lon)
            annotation.coordinate = location.coordinate
            annotation.title = merchant.name
            map.addAnnotation(annotation)
        }

        currentHeight += frameWidth! - 30 + spacer
        return map
    }
    
    func generateRecommendation(imgName: String, merchantName: String, merchantHour: String) -> UIView {
        let container = generateUnevenContainerView(left: generateRecommendImage(name: imgName), right: generateRecommendLabel(merchantName: merchantName), ratio: 0.4, x: 30, y: currentHeight, width: frameWidth! - 60, height: 100, spacing: spacer, sender: self)
        container.isUserInteractionEnabled = true
        let tapRecognizer = MerchantTappedGestureRecognizer(target: self, action: #selector(CategoryViewController.pushMerchantPageVC(sender:)))
        tapRecognizer.merchant = merchantLookUp(merchantName: merchantName)
        tapRecognizer.recipient = self.recipient
        container.addGestureRecognizer(tapRecognizer)
        return container
    }
    
    @objc func pushMerchantPageVC(sender: MerchantTappedGestureRecognizer) {
        let vc = MerchantPageViewController()
        vc.merchant = sender.merchant
        vc.selectedRecipient = sender.recipient
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func generateRecommendImage(name: String) -> UIImageView {
        let separator: Character = "."
        let tokens = name.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
        var img = UIImage(named: "tfl")
        if (tokens.count >= 2) {
            if let path = Bundle.main.path(forResource: String(tokens[0]), ofType: String(tokens[1])) {
                img = UIImage(contentsOfFile: path)
            }
        }
        let imgView = UIImageView()
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        
        return imgView
    }
    
    func generateRecommendLabel(merchantName: String) -> UIStackView {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.backgroundColor = visaBlue
        
        let categoryLabel = UILabel()
        categoryLabel.backgroundColor = visaBlue
        categoryLabel.textColor = visaOrange
        categoryLabel.text = "  " + categoryToString[self.category!]!
        categoryLabel.font = UIFont(name: categoryLabel.font.fontName, size: 15)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.backgroundColor = visaBlue
        nameLabel.textColor = .white
        nameLabel.text = "  " + merchantName
        nameLabel.font = UIFont(name: nameLabel.font.fontName, size: 18)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let separateLabel = UILabel()
        separateLabel.backgroundColor = visaBlue
        separateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let visitedLabel = UILabel()
        visitedLabel.backgroundColor = visaBlue
        visitedLabel.textColor = visaOrange
        visitedLabel.text = "   2 friend visited"
        visitedLabel.font = UIFont(name: visitedLabel.font.fontName, size: 11)
        visitedLabel.translatesAutoresizingMaskIntoConstraints = false
        
        stack.addArrangedSubview(categoryLabel)
        stack.addArrangedSubview(nameLabel)
        stack.addArrangedSubview(separateLabel)
        stack.addArrangedSubview(visitedLabel)
        
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }
    
    
    /* - MARK: Some helper functions */
    // This function generate uneven container view, UPDATING currentHeight in the end
    
    func incrementBySpacer(h: CGFloat) {
        currentHeight += h
    }

}
