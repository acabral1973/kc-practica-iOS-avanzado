//
//  DownloadDataInteractorNSURLSessionImpl.swift
//  MadridShops
//
//  Created by Diego Freniche Brito on 12/09/2017.
//  Copyright © 2017 KC. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSURLSessionImpl: DownloadAllShopsInteractor {
    
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure) {
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in

                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)

                    if error == nil {
                        // OK
                        let shops = parseShops(data: data!)
                        onSuccess(shops)
                    } else {
                        // Error
                        if let myError = onError {
                            myError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func execute(onSuccess: @escaping (Shops) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
}


class DownloadAllActivitiesInteractorNSURLSessionImpl: DownloadAllActivitiesInteractor {
    
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure) {
        let urlString = "https://madrid-shops.com/json_new/getActivities.php"
        
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                
                OperationQueue.main.addOperation {
                    if error == nil {
                        let activities = parseActivities(data: data!)
                        onSuccess(activities)
                    } else {
                        if let myError = onError {
                            myError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func execute(onSuccess: @escaping (Activities) -> Void) {
        execute(onSuccess: onSuccess, onError: nil)
    }
}
