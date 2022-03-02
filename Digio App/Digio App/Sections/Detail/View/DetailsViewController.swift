//
//  DetailsViewController.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit
import RxSwift

class DetailsViewController: UIViewController {

    private var viewModel: DetailViewModelProtocol!
    private let disposeBag: DisposeBag = DisposeBag()
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detalhes"
        
        self.bindUI()
    }
}

extension DetailsViewController {
    private func bindUI() {
        viewModel.items.drive() { item in
            self.title = item.name
        }.disposed(by: disposeBag)
    }
}
