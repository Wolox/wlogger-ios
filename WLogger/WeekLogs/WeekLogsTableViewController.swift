//
//  WeekLogsTableViewController.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

class WeekLogsTableViewController: UITableViewController {

    var viewModel: WeekLogsTableViewModel?
}

extension WeekLogsTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = UIRefreshControl()
        self.tableView.addSubview(refreshControl!)
        self.refreshControl?.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        tableView.registerNib(UINib(nibName: "LogTableViewCell", bundle: nil), forCellReuseIdentifier: LogTableViewCellIdentifier)
        
        viewModel?.fetchLogs.executing.producer.startWithNext { executing in
            if executing {
                // Show spinner
            } else {
                // Hide spinner
            }
        }
        
        viewModel?.fetchLogs.apply("").start { [unowned self] event in
            switch event {
            case .Next(_):
                print("Before reload table....")
                self.tableView.reloadData()
            case .Failed(let error):
                print("Error fetching logs \(error)")
            default: break
            }
        }
    }

    func handleRefresh(refreshControl: UIRefreshControl) {
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
}

extension WeekLogsTableViewController {

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfLogs ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(LogTableViewCellIdentifier, forIndexPath: indexPath)
        let logTableViewCell: LogTableViewCell = cell as! LogTableViewCell
        if let cellViewModel = viewModel?[indexPath.row] {
            logTableViewCell.bindViewModel(cellViewModel)
        }
        return cell
    }
    
}
