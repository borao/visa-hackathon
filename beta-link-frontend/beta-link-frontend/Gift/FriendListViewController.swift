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
    var friends: [Friend] = []
    var selectedMerchant: Merchant?
    
    /* - MARK: User Interface */
    let spacer: CGFloat = 10
    var currentHeight: CGFloat = 90
    var frameWidth: CGFloat?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for dict in friendDictionaries {
            guard let name = dict!["friendB_id__user__username"] as? String else { continue }
            guard let path = dict!["friendB_id__profilePic"] as? String else { continue }
            guard let id = dict!["friendB_id__id"] as? Int else { continue }
            friends.append(Friend(id: id, name: name + " the Minion", picturePath: path))
        }
        
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
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell") as? FriendTableViewCell {
            cell.imagePath = self.friends[indexPath.row].picturePath
            cell.nameLabel.text = self.friends[indexPath.row].name
            cell.userNameLabel.text = "@" + self.friends[indexPath.row].name
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
            let vc = AllMerchantsViewController()
            vc.selectedRecipient = self.friends[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SelectAmountViewController()
            vc.recipient = self.friends[indexPath.row]
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
