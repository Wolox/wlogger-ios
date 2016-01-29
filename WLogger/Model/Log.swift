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
    
    let startTime: String
    let stopTime: String
    let duration: Int
    let project: Project
    let activity: Activity
    let date: String                // I'd like this to be a NSDate
    let comments: String
    let trelloCard: String?
}

extension Log: Decodable {
    
    private static func createLog(startTime: String)(_ stopTime: String)(_ duration: Int)(_ project: Project)
        (_ activity: Activity)(_ date: String)(_ comments: String)(_ trelloCard: String?) -> Log {
            return Log(startTime: startTime, stopTime: stopTime, duration: duration, project: project, activity: activity, date: date, comments: comments, trelloCard: trelloCard)
    }
    
    public static func decode(j: JSON) -> Decoded<Log> {
        
        // Split expression into intermediate assignments to get past Swift's compiler limitations - feels super wrong
        // See https://github.com/thoughtbot/Argo/issues/5

        let l = Log.createLog
            <^> j <| "start_time"
            <*> j <| "stop_time"
        let l2 = l
            <*> j <| "duration"
            <*> j <| "project"
            <*> j <| "activity"
            <*> j <| "date"
            <*> j <| "comments"
            <*> j <|? "trello_card"
        return l2
    }
}
