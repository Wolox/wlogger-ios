//
//  APILogRepository.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import ReactiveCocoa
import Alamofire
import Argo
import Result

private let WeekLogsPath = "http://private-6f65cb-wlogger.apiary-mock.com/v1/logs"

public typealias JSONResult = _Result<AnyObject, NSError>.InternalResult
public typealias LogsResult = _Result<[Log], RepositoryError>.InternalResult

public extension Alamofire.Request {
    
    func response() -> SignalProducer<(NSURLRequest, NSHTTPURLResponse, NSData), NSError> {
        return SignalProducer { observable, disposable in
            disposable.addDisposable {  self.task.cancel() }
            
            self.response { request, response, data, maybeError in
                if let error = maybeError {
                    observable.sendFailed(error)
                } else {
                    observable.sendNext((request!, response!, data!))
                    observable.sendCompleted()
                }
            }
        }
    }
    
}

public extension NSJSONSerialization {
    
    static func JSONObjectWithData(data: NSData, options opt: NSJSONReadingOptions = []) -> JSONResult {
        let decode: () throws -> AnyObject = { try NSJSONSerialization.JSONObjectWithData(data, options: opt) as AnyObject }
        return JSONResult(attempt: decode)
    }
    
}

public struct APILogRepository: LogRepositoryType {

    public func getWeekLogs() -> SignalProducer<[Log], RepositoryError> {
        return Alamofire.request(Alamofire.Method.GET, WeekLogsPath, parameters: nil)
            .response()
            .flatMapError { SignalProducer(error: RepositoryError.RequestError($0)) }
            .flatMap(.Concat) { _, _ , data  in self.deserializeLogs(data) }
    }

}

private extension APILogRepository {
    
    func decodeLogs(JSON: AnyObject) -> LogsResult {
        guard let internalJSON = JSON as? [String : AnyObject], let logsJSON = internalJSON["logs"] else {
            let error = RepositoryError.JSONError(NSError(domain: "", code: 0, userInfo: nil))
            return LogsResult(error: error)
        }
        
        let decodedLogs: Decoded<[Log]> = decode(logsJSON)
        switch decodedLogs {
            case .Success(let logs): return LogsResult(value: logs)
            case .Failure(let error): return LogsResult(error: RepositoryError.DecodeError(error))
        }
    }
    
    func deserializeLogs(data: NSData) -> SignalProducer<[Log], RepositoryError> {
        return SignalProducer.attempt {
            NSJSONSerialization.JSONObjectWithData(data)
                .mapError { RepositoryError.JSONError($0) }
                .flatMap { self.decodeLogs($0) }
        }
    }
    
}
