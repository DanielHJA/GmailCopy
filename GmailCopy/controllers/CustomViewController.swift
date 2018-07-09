//
//  CustomViewController.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController {

    lazy var changeBarbuttonItem: UIBarButtonItem = {
        return UIBarButtonItem(title: "Ändra", style: .plain, target: self, action: nil)
    }()
    
    var transitionManager: TransitionManager = {
        return TransitionManager(percentage: 0.9, duration: 2.0, tapToDismiss: true, direction: .bottom, backgroundStyle: .blurred, shouldMinimizeBackground: true)
    }()
    
    lazy var bottomView: StartpageBottomFooterView = { [unowned self] in
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension CustomViewController: NewEmailDelegate {
    func openNewEmailController() {
        let vc = NewEmailViewController()
        vc.transitioningDelegate = transitionManager
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
    }
}
