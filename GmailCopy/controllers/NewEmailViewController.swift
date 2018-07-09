//
//  NewEmailViewController.swift
//  NapChords
//
//  Created by Daniel Hjärtström on 2018-06-26.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class NewEmailViewController: UIViewController {
    
    private lazy var emailView: NewEmailView = {
        let temp = NewEmailView(frame: CGRect.zero)
        temp.isUserInteractionEnabled = true
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.isOpaque = false
        view.backgroundColor = UIColor.clear
        emailView.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
