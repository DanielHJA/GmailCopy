//
//  TextFieldView.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-26.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class TextFieldView: UIView {
    
    var setTitle: String = "" {
        didSet {
            label.text = setTitle
        }
    }
    
    private lazy var separator: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.lightGray
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        return temp
    }()

    private lazy var label: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.lightGray
        temp.font = UIFont(name: "Halvetica", size: 15.0)
        temp.textAlignment = .left
        temp.numberOfLines = 1
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 60.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 50.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: separator.topAnchor).isActive = true
        return temp
    }()
    
    private lazy var addButton: UIButton = {
        let temp = UIButton()
        temp.setImage( UIImage(named: "unread_circle")!, for: .normal)
        temp.isEnabled = false
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15.0).isActive = true
        temp.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
        return temp
    }()
    
    private lazy var textfield: UITextField = {
        let temp = UITextField()
        temp.delegate = self
        temp.backgroundColor = UIColor.white
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -15.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: separator.topAnchor, constant: -2.0).isActive = true
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
        separator.isHidden = false
        label.isHidden = false
        addButton.isHidden = true
        textfield.isHidden = false
        separator.isHidden = false
    }
    
}

extension TextFieldView: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addButton.isEnabled = true
        addButton.isHidden = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        addButton.isEnabled = false
        addButton.isHidden = true
    }
    
}
