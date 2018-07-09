//
//  PresentationBackgroundView.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-07-04.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class PresentationBackgroundView: UIView {

    private lazy var blurView: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .regular)
        let temp = UIVisualEffectView(effect: effect)
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor).isActive = true
        temp.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        temp.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(frame: CGRect, style: BackgroundStyle) {
        self.init(frame: frame)
        switch style {
        case .blurred:
            blurView.isHidden = false
        case .dimmed:
            backgroundColor = UIColor.black.withAlphaComponent(0.4)
        case .none:
            backgroundColor = UIColor.clear
        }
    }
}
