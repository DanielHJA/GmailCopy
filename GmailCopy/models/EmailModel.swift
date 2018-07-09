//
//  EmailModel.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-25.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class EmailModel {

    var title: String
    var subject: String
    var content: String
    var time: String
    var isRead: Bool

    init(title: String, subject: String, content: String, time: String, isRead: Bool) {
        self.title = title
        self.subject = subject
        self.content = content
        self.time = time
        self.isRead = isRead
    }
    
}
