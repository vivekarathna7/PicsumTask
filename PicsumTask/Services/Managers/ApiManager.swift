//
//  ApiManager.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import Foundation

class ApiManager {
    public static let shared = ApiManager()

    func retrievePics(success: @escaping (([Pics]) -> Void), fail: @escaping ((HTTPError) -> Void)) {
        ServiceManager.shared.callService(urlString: Constants.PICS_URL, method: .get) { (response: [Pics]) in
            success(response)
        } fail: { error in
            fail(error)
        }
    }
}
