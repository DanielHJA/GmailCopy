//
//  NewEmailView.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-26.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

enum Corners {
    case topLeft, bottomLeft, topRight, bottomRight
    
    func translation() -> CACornerMask {
        switch self {
        case .topLeft:
            return .layerMinXMinYCorner
        case .bottomLeft:
            return .layerMinXMaxYCorner
        case .topRight:
            return .layerMaxXMinYCorner
        case .bottomRight:
            return .layerMaxXMaxYCorner
        }
    }
}

protocol RoundedCorners {}
extension RoundedCorners where Self : UIView {
    func roundTopCornersWithRadius(_ radius: CGFloat) {
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.cornerRadius = radius
    }
}


class RoundedCornerTopView: UIView, RoundedCorners {
    
    private lazy var indicator: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.lightGray
        temp.layer.cornerRadius = 5.0
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 4.0).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 6.0).isActive = true
        return temp
    }()

    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.font = UIFont(name: "DamascusMedium", size: 19.0)
        temp.textColor = UIColor.black
        temp.textAlignment = .center
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: indicator.bottomAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6).isActive = true
        return temp
    }()
    
    private lazy var dismissButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("Avbryt", for: .normal)
        temp.addTarget(self, action: #selector(dismiss(_:)), for: .touchUpInside)
        temp.setTitleColor(tintColor, for: .normal)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        return temp
    }()
    
    private lazy var sendButton: UIButton = {
        let temp = UIButton()
        temp.setTitle("Skicka", for: .normal)
        temp.addTarget(self, action: #selector(send(_:)), for: .touchUpInside)
        temp.isEnabled = false
        temp.setTitleColor(tintColor, for: .normal)
        temp.setTitleColor(UIColor.lightGray, for: .disabled)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor).isActive = true
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        roundTopCornersWithRadius(20.0)
        backgroundColor = Color.grayWhite
        clipsToBounds = true
        indicator.isHidden = false
        titleLabel.text =  "Nytt brev"
        dismissButton.isHidden = false
        sendButton.isHidden = false
        separator.isHidden = false
    }
    
    @objc private func dismiss(_ sender: UIBarButtonItem) {
        
    }
    
    @objc private func send(_ sender: UIBarButtonItem) {
        
    }
    
}
