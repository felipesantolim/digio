//
//  HomeViewModel.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import RxSwift
import RxRelay
import UIKit
import RxCocoa

enum HomeViewModelSteps: Step {
    case detail(DetailModel)
}

protocol HomeViewModelProtocol {
    var itemsMenu: Driver<[HomeCellType]> { get }
    var stop: Driver<Bool> { get }
    func cellSize(at indexPath: IndexPath) -> CGSize
    func fetch()
    func didSelected(with model: DetailModel)
}

class HomeViewModel: HomeViewModelProtocol, Stepper {

    var selectedStep = BehaviorRelay<HomeViewModelSteps?>(value: nil)
    
    private let apiCalling = HomeService()
    private let disposeBag = DisposeBag()
    
    private let itemsMenuRelay = BehaviorRelay<[HomeCellType]>(value: [])
    var itemsMenu: Driver<[HomeCellType]> {
        return itemsMenuRelay.asDriver()
    }
    
    private let stopRelay = BehaviorRelay<Bool>(value: false)
    var stop: Driver<Bool> {
        return stopRelay.asDriver()
    }
    
    func cellSize(at indexPath: IndexPath) -> CGSize {
        return itemsMenuRelay.value[indexPath.item].cellSize
    }
    
    func didSelected(with model: DetailModel) {
        selectedStep.accept(.detail(model))
    }
}

// MARK: Fetch All Items from API

extension HomeViewModel {
    func fetch() {
        apiCalling.fetchAll()
            .delay(.seconds(5), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] result in
                
                guard let self = self else { return }
                var items : [HomeCellType] = []
            
                items.append(.spotlight(result.spotlight ?? []))
                items.append(.cash(result.cash ?? Cash(
                title: "", bannerURL: "", cashDescription: "")))
                items.append(.product(result.products ?? []))
            
                self.itemsMenuRelay.accept(items)
                self.stopRelay.accept(true)
                
        },onError: { error in
            self.stopRelay.accept(true)
            debugPrint(error.localizedDescription)
        }).disposed(by: disposeBag)
    }
}
