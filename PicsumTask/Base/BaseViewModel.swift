//
//  BaseViewModel.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import UIKit

class BaseViewModel: NSObject {
    override init() {
        super.init()
        callService()
    }

    public func callService() {
        // childs should implement this
    }
}
