//
//  WeekLogsViewController.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

class WeekLogsViewController: UIViewController {

    @IBOutlet weak var loggerImageView: UIImageView!
    @IBOutlet weak var weekTotalTitleLabel: UILabel!
    @IBOutlet weak var weekTotalLabel: UILabel!
    @IBOutlet weak var weekLogsTableView: UIView!
    
    private var _weekLogsViewModel: WeekLogsViewModel
    
    private var _weekLogsTableViewController: WeekLogsTableViewController

    internal init() {
        _weekLogsTableViewController = WeekLogsTableViewController(nibName:String(WeekLogsTableViewController), bundle:nil)
        _weekLogsViewModel = WeekLogsViewModel(logRepository: APILogRepository())
        
        super.init(nibName: String(WeekLogsViewController), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension WeekLogsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.weekTotalTitleLabel.text = "week_total".localize.capitalizedString
        
        self.weekTotalLabel.text = String()
        _weekLogsViewModel.fetchLogsAmount.start { [unowned self] event in
            switch event {
            case .Next(let logsAmount):
                self.weekTotalLabel.text = logsAmount;
            case .Failed(let error):
                print("Error fetching logs amount \(error)")
            default: break
            }
        }
        
        self.loggerImageView.image = nil
        _weekLogsViewModel.fetchLoggerImage.start { [unowned self] event in
            switch event {
            case .Next(let loggerImage):
                self.loggerImageView.image = loggerImage;
            case .Failed(let error):
                print("Error fetching logger image \(error)")
            default: break
            }
        }
        
        let weekLogsTableViewController = getWeekLogsTableViewController()
        weekLogsTableView.addSubview(weekLogsTableViewController.view)
    }
    
    private func getWeekLogsTableViewController() -> UIViewController {
        _weekLogsTableViewController.viewModel = _weekLogsViewModel.weekLogsTableViewModel
        return _weekLogsTableViewController
    }

}


