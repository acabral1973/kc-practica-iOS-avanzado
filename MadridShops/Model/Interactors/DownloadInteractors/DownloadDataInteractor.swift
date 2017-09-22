//
//  DownloadDataInteractor.swift
//  MadridShops
//

import Foundation

protocol DownloadAllShopsInteractor {
    // execute: downloads all shops. Return on the main thread
    func execute(onSuccess: @escaping (Shops) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Shops) -> Void)
}

protocol DownloadAllActivitiesInteractor {
    // execute: downloads all activities. Return on the main thread
    func execute(onSuccess: @escaping (Activities) -> Void, onError: errorClosure)
    func execute(onSuccess: @escaping (Activities) -> Void)
}
