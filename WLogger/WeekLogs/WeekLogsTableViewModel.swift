//
//  WeekLogsTableViewModel.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa

func mapArray<ArrayValue, NewValue, Error: ErrorType>(producer: SignalProducer<[ArrayValue], Error>,
    transform: ArrayValue -> NewValue) -> SignalProducer<[NewValue], Error> {
    return producer.map { $0.map(transform) }
}

public class WeekLogsTableViewModel {
    
    private let _logs = MutableProperty<[LogViewModel]>([])
    public let fetchLogs: Action<AnyObject, [LogViewModel], RepositoryError>
    
    public var numberOfLogs: Int {
        print("number: \(_logs.value.count)")
        return _logs.value.count
    }
    
    public init(logRepository: LogRepository) {
        fetchLogs = Action { _ in
            let logsProducer = logRepository.getWeekLogs().observeOn(UIScheduler())
            return mapArray(logsProducer) { LogViewModel(log: $0) }
        }
        
        _logs <~ fetchLogs.values
    }
    
    public subscript(index: Int) -> LogViewModel {
        return _logs.value[index]
    }

}
