//
//  HomeService.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import RxSwift

public enum HomeServiceType: String { case GET }

protocol HomeServiceProtocol {
    func fetchAll() -> Observable<HomeModel> }

class HomeService: HomeServiceProtocol {
    func fetchAll() -> Observable<HomeModel> {
        return Observable.create { observer -> Disposable in
            
            let baseURL = URL(string: "https://7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com/sandbox/products")!
            var request = URLRequest(url: baseURL)
            request.httpMethod = HomeServiceType.GET.rawValue
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                do {
                    let model: HomeModel = try JSONDecoder().decode(HomeModel.self, from: data ?? Data())
                    observer.onNext(model)
                } catch let error { observer.onError(error) }
                observer.onCompleted()
            }
            task.resume()
            return Disposables.create { task.cancel() }
        }
    }
}

