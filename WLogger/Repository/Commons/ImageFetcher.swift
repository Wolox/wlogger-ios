//
//  ImageFetcher.swift
//  WLogger
//
//  Created by Pablo Giorgi on 1/28/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation
import ReactiveCocoa

public enum ImageFetcherError: ErrorType {
    case InvalidImageFormat
    case FetchError(NSError)
}

public typealias ImageProducer = SignalProducer<UIImage, ImageFetcherError>
public typealias ImageFetcher = NSURL -> ImageProducer

public func fetchImage(imageURL: NSURL) -> ImageProducer {
    return NSURLSession.sharedSession()
        .rac_dataWithRequest(NSURLRequest(URL: imageURL))
        .flatMapError { SignalProducer(error: .FetchError($0)) }
        .flatMap(.Concat) { data, _ -> ImageProducer in
            if let image = UIImage(data: data) {
                return SignalProducer(value: image)
            } else {
                return SignalProducer(error: .InvalidImageFormat)
            }
    }
}
