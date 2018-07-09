//
//  EmailTableViewCell.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class EmailTableViewCell: UITableViewCell {

    static let identifer: String = "EmailTableViewCell"

    private lazy var statusImageView: UIImageView = {
        let temp = UIImageView(image: nil)
        temp.contentMode = .scaleAspectFit
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5.0).isActive = true
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: 15.0).isActive = true
        temp.widthAnchor.constraint(equalToConstant: 15.0).isActive = true
        return temp
    }()
    
    private lazy var timeLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.lightGray
        temp.font = UIFont(name: "Helvetica", size: 15.0)
        temp.textAlignment = .right
        temp.numberOfLines = 1
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 10.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10.0).isActive = true
        temp.widthAnchor.constraint(equalToConstant: frame.width * 0.2).isActive = true
        temp.heightAnchor.constraint(equalToConstant: frame.height * 0.2).isActive = true
        return temp
    }()
    
    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "DamascusMedium", size: 17.0)
        temp.textAlignment = .left
        temp.numberOfLines = 1
        temp.lineBreakMode = .byTruncatingTail
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: topAnchor, constant: 12.0).isActive = true
        temp.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -20.0).isActive = true
        temp.heightAnchor.constraint(equalToConstant: frame.height * 0.2).isActive = true
        return temp
    }()
    
    private lazy var subjectLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.black
        temp.font = UIFont(name: "Helvetica", size: 16.0)
        temp.textAlignment = .left
        temp.numberOfLines = 1
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        temp.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0 ).isActive = true
        temp.heightAnchor.constraint(equalToConstant: frame.height * 0.15).isActive = true
        return temp
    }()
 
    private lazy var contentLabel: UILabel = {
        let temp = UILabel()
        temp.textColor = UIColor.lightGray
        temp.font = UIFont(name: "Helvetica", size: 16.0)
        temp.textAlignment = .left
        temp.numberOfLines = 2
        temp.lineBreakMode = .byTruncatingTail
        addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: statusImageView.trailingAnchor, constant: 5.0).isActive = true
        temp.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10.0).isActive = true
        temp.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: subjectLabel.bottomAnchor).isActive = true
        return temp
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupWith(_ model: EmailModel) {
        statusImageView.image = model.isRead ? nil : UIImage(named: "unread_circle")!
        timeLabel.text = model.time
        titleLabel.text = model.title
        subjectLabel.text = model.subject
        contentLabel.text = model.content
    }

}
