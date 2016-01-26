//
//  LogRepository.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import ReactiveCocoa
import Argo

public enum RepositoryError: ErrorType {
    case RequestError(NSError)
    case JSONError(NSError)
    case DecodeError(Argo.DecodeError)
}

public protocol LogRepository {

    func getWeekLogs() -> SignalProducer<[Log], RepositoryError>
    
}
