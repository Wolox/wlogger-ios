//
//  ImageFetcher.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/28/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa

public struct  ImageFetcher {
    
    public func fetchImage(imageURL: NSURL) -> SignalProducer<UIImage?, NSError> {
        return NSURLSession.sharedSession().rac_dataWithRequest(NSURLRequest(URL: imageURL)).map { UIImage(data: $0.0) }
    }

}
