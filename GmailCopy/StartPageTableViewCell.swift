//
//  StartPageTableViewCell.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-23.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class StartPageTableViewCell: UITableViewCell {
    
    static let identifer: String = "StartPageTableViewCell"
    var inboxType: InboxTypes?
    
    private lazy var viewForImage: UIImageView = {
        let temp = UIImageView(image: nil)
        temp.contentMode = .scaleAspectFit
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10.0).isActive = true
        temp.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.9) .isActive = true
        return temp
    }()
    
    private lazy var countLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.lightGray
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.textAlignment = .center
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.2).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20.0).isActive = true
        return temp
    }()
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "Helvetica", size: 17.0)
        temp.textAlignment = .left
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: 20.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: countLabel.leadingAnchor).isActive = true
        return temp
    }()

    private lazy var separator: UIView = {
        let temp = UIView()
        temp.backgroundColor = Color.grayWhite
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: viewForImage.trailingAnchor, constant: 20.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return temp
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWith(_ enumCase: InboxTypes) {
        let data = enumCase.cellData()
        viewForImage.image = data.image
        countLabel.text = data.count
        inboxType = data.type
        label.text = data.title 
        separator.isHidden = false
        accessoryType = .disclosureIndicator
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
