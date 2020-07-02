//
//  ImageDisplayViewController.swift
//  beta-link-frontend
//
//  Created by 徐乾智 on 7/1/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class ImageDisplayViewController: UIViewController, CustomVC {
    
    var name: String?
    
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 85
    var frameWidth: CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.frameWidth = self.view.frame.width
        self.view.backgroundColor = .white
        self.view.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        let imgView = UIImageView(frame: CGRect(x: 0, y: currentHeight, width: frameWidth!, height: self.view.frame.height - 200))

        imgView.image = UIImage(named: name!)
        self.view.addSubview(imgView)
        // Do any additional setup after loading the view.
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
