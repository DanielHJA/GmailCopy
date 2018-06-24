//
//  StartPageHeaderCell.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-23.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class StartPageHeaderCell: UITableViewCell {
    
    static let identifer: String = "StartPageHeaderCell"
    
    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "DamascusMedium", size: 30.0)
        temp.textAlignment = .left
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return temp
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupWithTitle(_ title: String) {
        backgroundColor = UIColor.white
        label.text = "Brevlådor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
