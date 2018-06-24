//
//  InboxesViewController.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-24.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class InboxesViewController: CustomViewController {

    private let headerMaxHeight: CGFloat = 115.0
    private let headerMinHeight: CGFloat = 55.0
    private var isExpanded: Bool = false
    
    var inboxType: InboxTypes?
    private var cells: [UITableViewCell] = [EmailTableViewCell(),EmailTableViewCell(),EmailTableViewCell(),EmailTableViewCell()]
    
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
            tableView.tableHeaderView = HeaderView(title: data.title, height: headerMinHeight, showsSearchbar: true)
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

extension InboxesViewController: UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
        if (actualPosition.y > 0){
            print("Up")
            if isExpanded {
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.tableHeaderView?.frame.size.height = self.headerMaxHeight
                }, completion: { (completion) in
                    self.tableView.tableHeaderView = self.tableView.tableHeaderView
                })
                isExpanded = false
            }
            
        } else{
            print("Down")
            if !isExpanded {
                UIView.animate(withDuration: 0.3, animations: {
                    self.tableView.tableHeaderView?.frame.size.height = self.headerMinHeight
                }, completion: { (completion) in
                    self.tableView.tableHeaderView = self.tableView.tableHeaderView
                })
                isExpanded = true
            }
        }
    }
    
}
