//
//  ViewController.swift
//  GmailCopy
//
//  Created by Daniel Hjärtström on 2018-06-23.
//  Copyright © 2018 Daniel Hjärtström. All rights reserved.
//

import UIKit

class ViewController: CustomViewController {
    
    private lazy var tableView: UITableView = {
        let temp = UITableView(frame: CGRect.zero, style: .grouped)
        temp.delegate = self
        temp.dataSource = self
        temp.tableHeaderView = HeaderView(title: "Brevlådor", height: 60.0, showsSearchbar: false)
        temp.register(StartPageTableViewCell.self, forCellReuseIdentifier: StartPageTableViewCell.identifer)
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
        temp.addTarget(self, action: #selector(handleRefresh(_:)), for: .valueChanged)
        temp.tintColor = UIColor.black
        temp.backgroundColor = UIColor.white
        return temp
    }()
    
    private var cells: [[UITableViewCell]] {
        return [[
            makeCell(.inbox),
            makeCell(.vip),
            makeCell(.flagged)
            ],[
            makeCell(.discarded),
            makeCell(.sent),
            makeCell(.trash),
            makeCell(.bin),
            makeCell(.all)
            ]]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
    }
    
    private func makeCell(_ enumCase: InboxTypes) -> StartPageTableViewCell {
        let cell = StartPageTableViewCell()
        cell.setupWith(enumCase)
        return cell
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cells[indexPath.section][indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == cells.count - 1 { return 20.0 }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CustomGrayHeader()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? StartPageTableViewCell else { return }
        let controller = InboxesViewController()
        controller.inboxType = cell.inboxType
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Brevlådor", style: .plain, target: nil, action: nil)
        navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 35.0 {
            title = "Brevlådor"
        } else if scrollView.contentOffset.y < 35.0 {
            title = ""
        }
    }
    
}


