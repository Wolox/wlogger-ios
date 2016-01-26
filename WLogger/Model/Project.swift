//
//  Project.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/10/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Argo
import Curry

public struct Project {

    let id: Int
    let name: String
}

extension Project: Decodable {
    public static func decode(j: JSON) -> Decoded<Project> {
        return curry(Project.init)
            <^> j <| "id"
            <*> j <| "name"
    }
}
