
//
//  Constants.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-23.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

struct Color {
    static let grayWhite: UIColor = UIColor(displayP3Red: 244/255.0, green: 245/255.0, blue: 247/255.0, alpha: 1.0)
}

struct Constants {
    
}

enum InboxTypes {
    case inbox
    case vip
    case flagged
    case discarded
    case sent
    case trash
    case bin
    case all
    case gmail

    func cellData() -> (image: UIImage?, title: String, count: String, type: InboxTypes) {
        switch self {
        case .inbox:
            return (UIImage(named: "inbox"), "Inkorg", "50", type: .inbox)
        case .vip:
            return (UIImage(named: "inbox"), "VIP", "", type: .vip)
        case .flagged:
            return (UIImage(named: "inbox"), "Flaggat", "100", type: .flagged)
        case .discarded:
            return (UIImage(named: "inbox"), "Utkast", "", type: .discarded)
        case .sent:
            return (UIImage(named: "inbox"), "Skickat", "", type: .sent)
        case .trash:
            return (UIImage(named: "inbox"), "Skräp", "2", type: .trash)
        case .bin:
            return (UIImage(named: "inbox"), "Papperskorg", "", type: .bin)
        case .all:
            return (UIImage(named: "inbox"), "Alla brev", "", type: .all)
        case .gmail:
            return (UIImage(named: "inbox"), "Gmail", "", type: .gmail)

        }
    }
}
