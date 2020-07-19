//
//  NetworkManager.swift
//  IBTechTutorial
//
//  Created by Burak Ceylan on 17.07.2020.
//  Copyright © 2020 Burak Ceylan. All rights reserved.
//

import Foundation
import Alamofire
import PKHUD

class NetworkManager {
    typealias SuccessHandler<T: Codable> = (T?) -> ()
    typealias ErrorHandler = (AFError) -> ()
    
    class func request<T: Codable>(url: String, method: HTTPMethod, parameters:T? = nil, responseType: T.Type = T.self, successCompletion: @escaping SuccessHandler<T>, errorCompletion: ErrorHandler? = nil) {
        
        showIndicator()
        
        let request = AF.request(url, method: method, parameters: parameters, encoder: JSONParameterEncoder.default)

        request.validate().responseDecodable(of: responseType) { (response) in
            hideIndicator()
            switch response.result {
            case let .success(result):
                successCompletion(result)
            case let .failure(error):
                errorCompletion?(error)
            }
        }

    }
    
    class func downloadImage(with url: String, dataHandler: @escaping (Data?) -> Void) {
        AF.download(url).responseData { (response) in
            dataHandler(response.value)
        }
    }
    
    private class func showIndicator() {
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    private class func hideIndicator() {
        PKHUD.sharedHUD.hide()
    }
}
