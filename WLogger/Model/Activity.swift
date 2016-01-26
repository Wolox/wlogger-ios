//
//  Activity.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Activity {
    
    let id: Int
    let name: String
}

extension Activity: Decodable {
    public static func decode(j: JSON) -> Decoded<Activity> {
        return curry(Activity.init)
            <^> j <| "id"
            <*> j <| "name"
    }
}
