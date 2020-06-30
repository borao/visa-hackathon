//
//  GiftViewController.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/22/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class FriendListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate, CustomVC {
    
    
    /* - MARK: Data input */
    var friendNames: [String]? = ["Bob the minion", "Kevin the minion", "Carl the minion", "Alice the minion"]
    var friendAccountNames: [String]? = ["@Bob the minion", "@Kevin the minion", "@Carl the minion", "@Alice the minion"]
    var selectedMerchant: Merchant?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 90
    var frameWidth: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameWidth = self.view.frame.width
        self.view.backgroundColor = .white
        self.view.addSubview(generateVisaImage(x: 0, y: currentHeight, width: frameWidth!, height: 50))
        currentHeight += 50
        let tableFrame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: self.view.frame.height - currentHeight - 20)
        let table = UITableView(frame: tableFrame)
        table.delegate = self
        table.dataSource = self
        table.isUserInteractionEnabled = true
        table.register(FriendTableViewCell.self, forCellReuseIdentifier: "friendCell")
        self.view.addSubview(table)
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendNames!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as? FriendTableViewCell {
            cell.imageName = "minion"
            cell.nameLabel.text = self.friendNames![indexPath.row]
            cell.userNameLabel.text = self.friendAccountNames![indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My friends"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (selectedMerchant == nil) {
            let vc = HomeViewController()
            vc.selectedRecipientName = self.friendNames![indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SelectAmountViewController()
            vc.recipientName = self.friendNames![indexPath.row]
            vc.merchant = self.selectedMerchant
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func generateSearchBar() -> UISearchBar {
        let frame = CGRect(x: 0, y: currentHeight, width: frameWidth!, height: 50)
        let bar = UISearchBar(frame: frame)
        bar.tintColor = visaBlue
        bar.barTintColor = visaBlue
        bar.isUserInteractionEnabled = true
        bar.delegate = self
        bar.becomeFirstResponder()
        currentHeight += 50 + spacer
        return bar
    }
    
    func incrementBySpacer(h: CGFloat) {
        currentHeight += h
    }
}
