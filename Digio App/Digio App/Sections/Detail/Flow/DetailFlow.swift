//
//  DetailFlow.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import RxSwift
import UIKit
import RxCocoa

class DetailFlow: Flow {
    var disposeBag: DisposeBag? = DisposeBag()
    var navigation: UINavigationController
    var viewModel: DetailViewModelProtocol!
    
    init(navigation: UINavigationController,
         viewModel: DetailViewModelProtocol) {
        
        self.navigation = navigation
        self.viewModel = viewModel
    }
    
    func start() {
        let vc = DetailsViewController(viewModel: viewModel)
        navigation.pushViewController(vc, animated: true)
    }
}
