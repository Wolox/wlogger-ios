//
//  LogTableViewCell.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

let LogTableViewCellIdentifier = "LogTableViewCell"

public class LogTableViewCell: UITableViewCell {

    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    
    public func bindViewModel(logViewModel: LogViewModel) {
        projectLabel.text = logViewModel.projectName
        activityLabel.text = logViewModel.activityName
        commentsLabel.text = logViewModel.comments
        durationLabel.text = logViewModel.duration
    }

}
