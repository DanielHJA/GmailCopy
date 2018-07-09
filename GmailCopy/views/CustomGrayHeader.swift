//
//  CustomGrayHeader.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class CustomGrayHeader: UITableViewHeaderFooterView {
    
    private func makeSeparator() -> UIView {
        let temp = UIView()
        temp.backgroundColor = UIColor.lightGray
        temp.translatesAutoresizingMaskIntoConstraints = false
        return temp
    }
    
    convenience init() {
        self.init(reuseIdentifier: nil)
        self.backgroundView = UIView(frame: self.bounds)
        self.backgroundView?.backgroundColor = Color.grayWhite
    
        let topSeparator = makeSeparator()
        let bottomSeparator = makeSeparator()
        
        addSubview(topSeparator)
        addSubview(bottomSeparator)
        
        let topSeparatorConstraints: [NSLayoutConstraint] = [
            topSeparator.topAnchor.constraint(equalTo: topAnchor),
            topSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            topSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.5)
        ]
        
        let bottomSeparatorConstraints: [NSLayoutConstraint] = [
            bottomSeparator.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5)
        ]
        
        addConstraints(topSeparatorConstraints)
        addConstraints(bottomSeparatorConstraints)
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
