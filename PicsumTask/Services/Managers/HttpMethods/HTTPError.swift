//
//  HTTPError.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import Foundation

enum HTTPError: Error {
    case urlFailed
    case noData
    case requestError
    case parsingFailed
}
