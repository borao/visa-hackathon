//
//  QRCodeViewController.swift
//  beta-link-frontend
//
//  Created by 徐乾智 on 7/1/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        let imgView = UIImageView(frame: CGRect(origin: self.view.center, size: CGSize(width: 200, height: 200)))
        imgView.center = self.view.center
        imgView.image = UIImage(named: "qr")
        self.view.addSubview(imgView)
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

}
