//
//  FriendTableViewCell.swift
//  Beta Link
//
//  Created by 徐乾智 on 6/23/20.
//  Copyright © 2020 徐乾智. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
    
    var imagePath: String? {
        didSet {
            let separator: Character = "."
            let tokens = imagePath!.split(separator: separator, maxSplits: 1, omittingEmptySubsequences: true)
            var img = UIImage(named: "minion")
            if (tokens.count >= 2) {
                if let path = Bundle.main.path(forResource: String(tokens[0]), ofType: String(tokens[1])) {
                    img = UIImage(contentsOfFile: path)
                }
            }
            profileImageView.image = img
        }
    }
    
    let profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        imgView.layer.cornerRadius = 35
        imgView.layer.borderWidth = 1.5
        imgView.layer.borderColor = visaOrange.cgColor
        return imgView
    }()
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor =  visaOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNameLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  skyBlue
        label.backgroundColor =  .white
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(profileImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(userNameLabel)
        self.contentView.addSubview(containerView)

        profileImageView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant:70).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant:70).isActive = true
        
        containerView.centerYAnchor.constraint(equalTo:self.contentView.centerYAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.profileImageView.trailingAnchor, constant:30).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.heightAnchor.constraint(equalToConstant:40).isActive = true

        nameLabel.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 20)

        userNameLabel.topAnchor.constraint(equalTo:self.nameLabel.bottomAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
        userNameLabel.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
        userNameLabel.bottomAnchor.constraint(equalTo:self.containerView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
