//
//  LogViewModel.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public struct LogViewModel {

    public let projectName: String
    public let activityName: String
    public let comments: String
    public let duration: String
    
    public init(log: Log) {
        projectName = log.project.name
        activityName = log.activity.name
        comments = log.comments
        duration = secondsStringFormatted(log.duration)
    }
    
}

private func secondsStringFormatted(var seconds: Int) -> String {
    let hours = seconds / 3600
    seconds = seconds - 3600 * hours
    let minutes = seconds / 60
    seconds = seconds - 60 * minutes
    return "\(String(format: "%02d", hours)):\(String(format: "%02d", minutes)):\(String(format: "%02d", seconds))"
}
