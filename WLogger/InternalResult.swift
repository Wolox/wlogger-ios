//
//  InternalResult.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/26/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import Result

public struct _Result<Value, Error: ErrorType> {
    
    public typealias InternalResult = Result<Value, Error>
    
}