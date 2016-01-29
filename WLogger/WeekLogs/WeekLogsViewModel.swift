//
//  WeekLogsViewModel.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/27/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa

public class WeekLogsViewModel {

    public let weekTotalTitle: String
    
    private let logsAmount = MutableProperty<String>("")
    public let fetchLogsAmount: Action<AnyObject, String, RepositoryError>
    
    private let loggerImage = MutableProperty<UIImage?>(nil)
    public let fetchLoggerImage: Action<AnyObject, UIImage?, NSError>
    
    public let weekLogsTableViewModel: WeekLogsTableViewModel
    
    public init(imageFetcher: ImageFetcher, logRepository: LogRepository) {
        weekTotalTitle = "week total"
        weekLogsTableViewModel = WeekLogsTableViewModel(logRepository: logRepository)

        fetchLogsAmount = Action { _ in
            let logsProducer = logRepository.getWeekLogsAmount().observeOn(UIScheduler())
            return logsProducer.map( { $0 } )
        }
        logsAmount <~ fetchLogsAmount.values

        fetchLoggerImage = Action { _ in
            let profileImagePath = "http://www.wired.com/wp-content/uploads/2015/09/google-logo.jpg"
            let profileImageProducer = imageFetcher.fetchImage(NSURL(string: profileImagePath)!).producer
            return profileImageProducer.map( { $0 } )
        }
        loggerImage <~ fetchLoggerImage.values
    }
    
}
