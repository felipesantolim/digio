//
//  DetailViewModel.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import RxCocoa
import RxSwift

protocol DetailViewModelProtocol {
    var items: Driver<DetailModel> { get }
}

class DetailViewModel: DetailViewModelProtocol {
    
    private let itemsRelay = BehaviorRelay<DetailModel>(
        value: DetailModel(name: "", desc: "", url: ""))
    var items: Driver<DetailModel> {
        return itemsRelay.asDriver()
    }
    
    init(model: DetailModel) {
        self.itemsRelay.accept(model)
    }
}
