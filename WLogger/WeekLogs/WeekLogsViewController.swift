//
//  WeekLogsViewController.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

class WeekLogsViewController: UIViewController {

    @IBOutlet weak var weekTotalTitleLabel: UILabel!
    @IBOutlet weak var weekTotalLabel: UILabel!
    @IBOutlet weak var weekLogsTableView: UIView!
    
    private var _weekLogsTableViewController: WeekLogsTableViewController
    
    internal init() {
        _weekLogsTableViewController = WeekLogsTableViewController(nibName:String(WeekLogsTableViewController), bundle:nil)
        
        super.init(nibName: String(WeekLogsViewController), bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let weekLogsTableViewController = getWeekLogsTableViewController()
        weekLogsTableView.addSubview(weekLogsTableViewController.view)
    }
    
    private func getWeekLogsTableViewController() -> UIViewController {
        _weekLogsTableViewController.viewModel = WeekLogsTableViewModel(logRepository: APILogRepository())
        return _weekLogsTableViewController
    }

}
