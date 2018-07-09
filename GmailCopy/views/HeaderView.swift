//
//  HeaderView.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class HeaderView: UIView {

    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "DamascusMedium", size: 30.0)
        temp.textAlignment = .left
        temp.numberOfLines = 1
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 20.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
        return temp
    }()
    
    private lazy var searchbar: UISearchBar = {
        let temp = UISearchBar()
        temp.isHidden = true
        temp.searchBarStyle = .minimal
        temp.barTintColor = Color.grayWhite
        temp.placeholder = "Sök"
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: label.bottomAnchor, constant: -10.0).isActive = true
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.95).isActive = true
        return temp
    }()
    
    private lazy var separator: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.lightGray
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return temp
    }()
    
    convenience init(title: String, height: CGFloat, showsSearchbar: Bool) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        backgroundColor = UIColor.white
        separator.isHidden = false
        label.text = title
        
        if showsSearchbar {
            searchbar.isHidden = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
