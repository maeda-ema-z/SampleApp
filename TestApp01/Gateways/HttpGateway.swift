//
//  HttpGateway.swift
//  TestApp01
//
//  Created by 1779-Apple on 2020/02/21.
//  Copyright © 2020 admin. All rights reserved.
//

import RxSwift
import RxCocoa

class HttpGateway<T> {

    enum MyError: Error {
        case unknown
    }

    func createHttpGetObservable(url: String, decoder: @escaping (Data) -> T) -> Single<T> {
        print("url=\(url)")
        return Single<T>.create( subscribe : { (observer) -> Disposable in
            if let url: URL = URL(string: url) {
                let task: URLSessionTask  = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
                        print("data: \(String(describing: data))")
                        print("response: \(String(describing: response))")
                        print("error: \(String(describing: error))")
                        if let data = data {
                            let results = decoder(data)
                            observer(.success(results))
                        } else {
                            observer(.error(error ?? MyError.unknown))
                        }
                })
                task.resume()
            } else {
                observer(.error(MyError.unknown))
            }
            return Disposables.create()
        })
    }

    func createHttpPostObservable(url: String, param: String, decoder: @escaping (Data) -> T) -> Single<T> {
        print("url=\(url)")
        return Single<T>.create( subscribe : { (observer) -> Disposable in
            if let url: URL = URL(string: url) {
                var request = URLRequest(url: url)
                request.httpMethod = "POST"
                request.httpBody = param.data(using: .utf8)
                let task: URLSessionTask  = URLSession.shared.dataTask(with: request, completionHandler: {data, response, error in
                        print("data: \(String(describing: data))")
                        print("response: \(String(describing: response))")
                        print("error: \(String(describing: error))")
                        if let data = data {
                            let results = decoder(data)
                            observer(.success(results))
                        } else {
                            observer(.error(error ?? MyError.unknown))
                        }
                })
                task.resume()
            } else {
                observer(.error(MyError.unknown))
            }
            return Disposables.create()
        })
    }
}
