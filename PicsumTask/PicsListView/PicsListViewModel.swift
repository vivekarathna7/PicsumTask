//
//  PicsListViewModel.swift
//  PicsumTask
//
//  Created by Viveka G on 07/05/23.
//

import Foundation

class PicsListViewModel: BaseViewModel {
    var picsLoaded: (([Pics]?, Bool) -> Void)?
    var picsList: [Pics]?
    
    override func callService() {
        ApiManager.shared.retrievePics { [weak self] response in
            self?.picsList = response
            self?.handleResponse(response: response, success: true)
        } fail: { [weak self] _ in
            self?.handleResponse(response: nil, success: false)
        }
    }
    
    private func handleResponse(response: [Pics]?, success: Bool) {
        if let beersLoaded = self.picsLoaded {
            beersLoaded(response, success)
        }
    }
    
    func numberOrRows() -> Int {
        return self.picsList?.count ?? 0
    }
    
    func getPic(index: Int) -> Pics? {
        return self.picsList?[index]
    }
}
