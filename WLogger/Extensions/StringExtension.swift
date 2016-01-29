//
//  StringExtension.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/28/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import UIKit

public extension String {

    var localize: String {
        return NSLocalizedString(self, tableName: nil, bundle: NSBundle.mainBundle(), value: "", comment: "")
    }
    
}
