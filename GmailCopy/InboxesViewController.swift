//
//  InboxesViewController.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class InboxesViewController: CustomViewController {

    var inboxType: InboxTypes?
    var cells: [UITableViewCell] = [EmailTableViewCell(),EmailTableViewCell(),EmailTableViewCell(),EmailTableViewCell()]
    
    private lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect.zero, style: .grouped)
        temp.delegate = self
        temp.dataSource = self
        temp.register(EmailTableViewCell.self, forCellReuseIdentifier: EmailTableViewCell.identifer)
        temp.separatorStyle = .none
        temp.addSubview(refreshControl)
        view.addSubview(temp)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        temp.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        temp.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        temp.bottomAnchor.constraint(equalTo: self.bottomView.topAnchor).isActive = true
        return temp
    }()
    
    lazy var refreshControl: UIRefreshControl = {
        let temp = UIRefreshControl()
        temp.addTarget(self, action: #selector(handleRefresh(_:)), for: UIControlEvents.valueChanged)
        temp.tintColor = UIColor.black
        temp.backgroundColor = UIColor.white
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        
        if let data = inboxType?.cellData() {
            tableView.tableHeaderView = HeaderView(title: data.title, height: 125.0, showsSearchbar: true)
        }
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    override func openNewEmailController() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension InboxesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EmailTableViewCell.identifer, for: indexPath) as? EmailTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
    
}
