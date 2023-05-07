//
//  BaseViewController.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showLoader() {
        Loader.shared.show()
    }

    func hideLoader() {
        Loader.shared.hide()
    }
}
