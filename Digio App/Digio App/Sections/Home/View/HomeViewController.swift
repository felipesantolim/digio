//
//  ViewController.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit
import RxSwift
import RxCocoa
import Lottie
import CoreMedia

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: BaseCollectionView!
    @IBOutlet weak var animationView: AnimationView!
    
    private let disposeBag: DisposeBag = DisposeBag()
    private var viewModel: HomeViewModelProtocol!
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Protótipo Digio"
        
        self.bindUI()
        self.loading()
        self.viewModel.fetch()
        self.setupCollectionView()
    }
}

// MARK: setup lottie animation

extension HomeViewController {
    private func loading() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.7
        animationView.play()
    }
}

// MARK: bind UI

extension HomeViewController {
    private func bindUI() {
        viewModel?
            .itemsMenu
            .drive(collectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                let cell = collectionView.dequeueBaseCell(with: element.cellType(), for: indexPath)
                cell.bindData(element, self)
                return cell
            }.disposed(by: disposeBag)
        
        viewModel?
            .stop
            .drive() { result in
            if result == true {
                self.animationView.pause()
                self.animationView.isHidden = true }
        }.disposed(by: disposeBag)
    }
}

// MARK: Setup Collection binds

extension HomeViewController {
    private func setupCollectionView() {
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.register(cellTypes: [SpotlightViewCell.self,
                                            CashViewCell.self,
                                            ProductViewCell.self])
    }
}

// MARK: Setup Collection Layout

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel?.cellSize(at: indexPath) ?? CGSize.zero
    }
}

// MARK: SpotlightViewCellDelegate

extension HomeViewController: SpotlightViewCellDelegate {
    func spotlightClicked(_ value: DetailModel) {
        viewModel.didSelected(with: value)
    }
}

// MARK: CashViewCellDelegate

extension HomeViewController: CashViewCellDelegate {
    func cashClicked(_ value: DetailModel) {
        viewModel.didSelected(with: value)
    }
}

// MARK: ProductViewCellDelegate

extension HomeViewController: ProductViewCellDelegate {
    func productClicked(_ value: DetailModel) {
        viewModel.didSelected(with: value)
    }
}
