//
//  StartpageBottomFooterView.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-23.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

protocol NewEmailDelegate: class {
    func openNewEmailController()
}

class StartpageBottomFooterView: UIView {
    
    weak var delegate: NewEmailDelegate?
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }

    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "Helvetica", size: 12.0)
        temp.textAlignment = .center
        temp.adjustsFontSizeToFitWidth = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: button.leadingAnchor).isActive = true
        return temp
    }()
    
    private lazy var button: UIButton = {
        let temp = UIButton()
        temp.isHidden = true
        temp.tintColor = tintColor
        temp.setImage(UIImage(named: "edit"), for: .normal)
        temp.addTarget(self, action: #selector(didPressNewEmailButton), for: .touchUpInside)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 5.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5.0).isActive = true
        temp.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        return temp
    }()
    
    private lazy var separator: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.lightGray
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
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
        backgroundColor = Color.grayWhite
        button.isHidden = false
        label.text = "Uppdaterades alldeles nyss"
        separator.isHidden = false
    }
    
    @objc private func didPressNewEmailButton() {
        delegate?.openNewEmailController()
    }
}
