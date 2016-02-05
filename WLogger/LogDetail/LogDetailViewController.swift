//
//  LogDetailViewController.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

class LogDetailViewController: UIViewController {

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!

    @IBOutlet weak var durationTitleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var dateTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    @IBOutlet weak var commentsLabel: UILabel!

    private var _logViewModel: LogViewModel
    
    internal init(logViewModel: LogViewModel) {
        self._logViewModel = logViewModel
        
        super.init(nibName: String(LogDetailViewController), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LogDetailViewController {
    
    override func viewDidLoad() {
        self.setTexts()
        self.bindViewModel()
    }
    
    func setTexts() {
        durationTitleLabel.text = "duration".localize.uppercaseString
        dateTitleLabel.text = "date".localize.uppercaseString
    }
    
    func bindViewModel() {
        projectLabel.text = _logViewModel.projectName.uppercaseString
        activityLabel.text = _logViewModel.activityName
        commentsLabel.text = _logViewModel.comments
        durationLabel.text = _logViewModel.duration
    }
    
}

