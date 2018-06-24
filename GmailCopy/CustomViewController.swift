//
//  CustomViewController.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, NewEmailDelegate {

    lazy var changeBarbuttonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Ändra", style: .plain, target: self, action: nil)
    }()
    
    lazy var bottomView: StartpageBottomFooterView = {
        let temp = StartpageBottomFooterView(frame: CGRect.zero)
        temp.delegate = self
        temp.isHidden = true
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.07).isActive = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.isHidden = false
        navigationItem.rightBarButtonItem = changeBarbuttonItem
        view.backgroundColor = UIColor.white
    }

    func openNewEmailController() { print("1") }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

