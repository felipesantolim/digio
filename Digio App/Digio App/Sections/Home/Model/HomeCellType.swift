//
//  HomeCellType.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import UIKit

enum HomeCellType {
    case spotlight([Spotlight])
    case product([Product])
    case cash(Cash)
    
    func cellType<T: BaseCollectionViewCell>() -> T.Type {
        switch self {
        case .spotlight:
            return SpotlightViewCell.self as? T.Type ?? T.self
        case .cash:
            return CashViewCell.self as? T.Type ?? T.self
        case .product:
            return ProductViewCell.self as? T.Type ?? T.self
        }
    }
    
    var cellSize: CGSize {
        switch self {
        case .spotlight:
            return CGSize(width: UIScreen.main.bounds.width, height: 225)
        case .cash:
            return CGSize(width: UIScreen.main.bounds.width, height: 160)
        case .product:
            return CGSize(width: UIScreen.main.bounds.width, height: 205)
        }
    }
}
