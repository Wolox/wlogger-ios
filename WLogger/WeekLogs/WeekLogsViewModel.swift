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
    let fetchLogsAmount: SignalProducer<String, RepositoryError>
    
    private let loggerImage = MutableProperty<UIImage?>(nil)
    let fetchLoggerImage: SignalProducer<UIImage, ImageFetcherError>
    static private let FetchLoggerImagePath = "http://www.wired.com/wp-content/uploads/2015/09/google-logo.jpg"
    
    public let weekLogsTableViewModel: WeekLogsTableViewModel
    
    public init(imageFetcher: ImageFetcher = fetchImage, logRepository: LogRepositoryType) {
        weekTotalTitle = "week total"
        weekLogsTableViewModel = WeekLogsTableViewModel(logRepository: logRepository)
        
        self.fetchLogsAmount =  logRepository.getWeekLogsAmount().observeOn(UIScheduler())
        logsAmount <~ fetchLogsAmount.flatMapError { _ in SignalProducer.empty }
        
        let fetchLoggerImageURL = NSURL(string: WeekLogsViewModel.FetchLoggerImagePath)!
        self.fetchLoggerImage = imageFetcher(fetchLoggerImageURL).replayLazily(1).observeOn(UIScheduler())
        loggerImage <~ fetchLoggerImage.flatMapError { _ in SignalProducer.empty }.map { $0 }
    }
    
}
