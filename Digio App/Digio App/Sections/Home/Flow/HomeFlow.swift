//
//  HomeFlow.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

class HomeFlow: Flow {
    
    var disposeBag: DisposeBag? = DisposeBag()
    var navigation: UINavigationController
    var window: UIWindow?
    var detailFlow: DetailFlow?
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
        
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithDefaultBackground()
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        }
    }
    
    func start() {
        guard let disposeBag = disposeBag else { return }
        let viewModel = HomeViewModel()
        viewModel.selectedStep
            .asDriver()
            .drive(onNext: { [weak self] nextFlow in
                switch nextFlow {
                case .detail(let item):
                    self?.goToNextOne(item)
                case .none: break
                }
        }).disposed(by: disposeBag)
        
        let vc = HomeViewController(viewModel: viewModel)
        self.navigation = UINavigationController(rootViewController: vc)
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = self.navigation
        window.makeKeyAndVisible()
        
        self.window = window
    }
}

extension HomeFlow {
    private func goToNextOne(_ value: DetailModel) {
        let viewModel = DetailViewModel(model: value)
        detailFlow = DetailFlow(navigation: navigation,
                                viewModel: viewModel)
        detailFlow?.start()
    }
}
