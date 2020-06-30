//
//  CategoryViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/24/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit
import MapKit

class CategoryViewController: UIViewController {
    /* - MARK: Data input */
    var category: MerchantCaterogy?
    var merchants: [Merchant]?
    var recipientName: String?
    
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
        
        scrollView.addSubview(generateVisaImage())
        scrollView.addSubview(generateMap())
        scrollView.addSubview(generateSeparationLine())
        for i in 0 ..< self.merchants!.count {
            scrollView.addSubview(generateRecommendation(imgName: "tfl", merchantName: self.merchants![i].name, merchantHour: self.merchants![i].hour))
        }
        
        scrollView.contentSize = CGSize(width: frameWidth!, height: currentHeight + 10 * spacer)
        
        // Do any additional setup after loading the view.
    }
    
    func generateMap() -> MKMapView {
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: frameWidth! - 30)
        let map = MKMapView(frame: frame)
        let initialLocation = CLLocation(latitude: 37.8396956, longitude: -122.2888659)
        let ikes = CLLocation(latitude: 37.8390459, longitude: -122.2917944)
        let superDuper = CLLocation(latitude: 37.8412014, longitude: -122.2937132)
        let initialRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
        map.setRegion(initialRegion, animated: true)
        
        let homeAnnotation = MKPointAnnotation()
        homeAnnotation.coordinate = initialLocation.coordinate
        homeAnnotation.title = "Parc on Powell"
        homeAnnotation.subtitle = "Shiro's"
        map.addAnnotation(homeAnnotation)
        
        let ikesAnnotation = MKPointAnnotation()
        ikesAnnotation.coordinate = ikes.coordinate
        ikesAnnotation.title = "Ike's Sandwich"
        map.addAnnotation(ikesAnnotation)
        
        let superDuperAnnotation = MKPointAnnotation()
        superDuperAnnotation.coordinate = superDuper.coordinate
        superDuperAnnotation.title = "Super Duper Burger"
        map.addAnnotation(superDuperAnnotation)
        
        currentHeight += frameWidth! - 30 + spacer
        return map
    }
    
    func generateRecommendation(imgName: String, merchantName: String, merchantHour: String) -> UIView {
        let container = generateUnevenContainerView(left: generateRecommendImage(name: "tfl"), right: generateRecommendLabel(merchantName: merchantName), ratio: 0.4, x: 30, y: currentHeight, width: frameWidth! - 60, height: 100, spacing: spacer)
        container.isUserInteractionEnabled = true
        let tapRecognizer = MerchantTappedGestureRecognizer(target: self, action: #selector(CategoryViewController.pushMerchantPageVC(sender:)))
        tapRecognizer.merchant = merchantLookUp(merchantName: merchantName)
        tapRecognizer.recipientName = self.recipientName
        container.addGestureRecognizer(tapRecognizer)
        return container
    }
    
    @objc func pushMerchantPageVC(sender: MerchantTappedGestureRecognizer) {
        let vc = MerchantPageViewController()
        vc.merchant = sender.merchant
        vc.selectedRecipientName = sender.recipientName
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func generateRecommendImage(name: String) -> UIImageView {
        let img = UIImage(named: name)
        let imgView = UIImageView()
        imgView.image = img
        imgView.contentMode = .scaleAspectFill
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
        switch self.category! {
        case .coffee:
            categoryLabel.text = "   Coffee & Tea"
        case .fastFood:
            categoryLabel.text = "   Fast Food"
        default:
            categoryLabel.text = "  Not yet implemented"
        }
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
        container.backgroundColor = visaBlue
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
    
    func generateSeparationLine() -> UILabel {
        let color = visaBlue
        let frame = CGRect(x: 100, y: currentHeight, width: frameWidth! - 200, height: 3)
        let label = UILabel(frame: frame)
        label.backgroundColor = color
        currentHeight += 5 + spacer
        return label
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
