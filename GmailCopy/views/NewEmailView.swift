//
//  NewEmailView.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-26.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class NewEmailView: UIView, RoundedCorners {
    
    private lazy var topView: RoundedCornerTopView = {
        let temp = RoundedCornerTopView(frame: CGRect.zero)
        temp.isHidden = true
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        return temp
    }()
    
    private lazy var toTextView: TextFieldView = {
        let temp = TextFieldView(frame: CGRect.zero)
        temp.setTitle = "Till:"
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return temp
    }()

    private lazy var copyTextView: TextFieldView = {
        let temp = TextFieldView(frame: CGRect.zero)
        temp.setTitle = "Kopia/Dold kopia:"
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: toTextView.bottomAnchor, constant: 2.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return temp
    }()
    
    private lazy var subjectTextView: TextFieldView = {
        let temp = TextFieldView(frame: CGRect.zero)
        temp.setTitle = "Ämne:"
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: copyTextView.bottomAnchor, constant: 2.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        return temp
    }()

    private lazy var textfield: UITextView = {
        let temp = UITextView()
        temp.backgroundColor = UIColor.white
        temp.text = "Skickat från min IPhone"
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: subjectTextView.bottomAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
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
        backgroundColor = UIColor.white
        topView.isHidden = false
        toTextView.isHidden = false
        copyTextView.isHidden = false
        subjectTextView.isHidden = false
        textfield.isHidden = false
    }
    
}
