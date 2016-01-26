//
//  Log.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Log {
    
//    let startTime: String
//    let stopTime: String
    let duration: Int
    let project: Project
    let activity: Activity
    let date: String                // I'd like this to be a NSDate
    let comments: String
//    let trelloCard: Int
}

extension Log: Decodable {
    public static func decode(j: JSON) -> Decoded<Log> {
        
        // Split expression into intermediate assignments to get past Swift's compiler limitations - feels super wrong
        // See https://github.com/thoughtbot/Argo/issues/5

        return curry(Log.init)
//            <^> j <| "start_time"
//            <*> j <| "stop_time"
            <^> j <| "duration"
            <*> j <| "project"
            <*> j <| "activity"
            <*> j <| "date"
            <*> j <| "comments"
//            <*> j <| "trello_card"
    }
}
