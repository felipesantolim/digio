//
//  UICollectionView+Utils.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import Foundation
import UIKit

public extension UICollectionView {
    
    func register<T: UICollectionViewCell>(cellType: T.Type, bundle: Bundle? = nil) {
        let className = cellType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forCellWithReuseIdentifier: className)
    }

    func register(cellTypes: [UICollectionViewCell.Type], bundle: Bundle? = nil) {
        cellTypes.forEach { register(cellType: $0, bundle: bundle) }
    }
    
    func register<T: UICollectionReusableView>(
        reusableViewType: T.Type,
        ofKind kind: String = UICollectionView.elementKindSectionHeader,
        bundle: Bundle? = nil
        ) {
        let className = reusableViewType.className
        let nib = UINib(nibName: className, bundle: bundle)
        register(nib, forSupplementaryViewOfKind: kind, withReuseIdentifier: className)
    }
    
    func register<T: UICollectionReusableView>(
        reusableViewTypes: [T.Type],
        ofKind kind: String = UICollectionView.elementKindSectionHeader,
        bundle: Bundle? = nil
        ) {
        reusableViewTypes.forEach { register(reusableViewType: $0, ofKind: kind, bundle: bundle) }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(
        with type: T.Type,
        for indexPath: IndexPath
        ) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    func dequeueBaseCell<T: BaseCollectionViewCell>(
        with type: T.Type,
        for row: Int
        ) -> T {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    func dequeueBaseCell<T: BaseCollectionViewCell>(
        with type: T.Type,
        for indexPath: IndexPath
        ) -> T {
        
        guard let cell = dequeueReusableCell(withReuseIdentifier: type.className, for: indexPath) as? T else {
            return T()
        }
        return cell
    }
    
    func dequeueBind<T: BaseCollectionViewCell>(cell: T.Type, row: Int, item: Any?)
        -> T {
        let indexPath = IndexPath(row: row, section: 0)
        guard let cell = dequeueReusableCell(withReuseIdentifier: cell.className, for: indexPath) as? T else {
            return T()
        }
        cell.bindData(item)
        return cell
    }
    
    func dequeueReusableView<T: UICollectionReusableView>(
        with type: T.Type,
        for indexPath: IndexPath,
        ofKind kind: String = UICollectionView.elementKindSectionHeader
        ) -> T? {
        return dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.className, for: indexPath) as? T
    }
    
    func dequeueReusableBaseViews<T: UICollectionReusableView>(
        with type: T.Type,
        for indexPath: IndexPath,
        ofKind kind: String = UICollectionView.elementKindSectionHeader) -> T {
        if let reusable = dequeueReusableSupplementaryView(ofKind: kind,
                                                           withReuseIdentifier: type.className,
                                                           for: indexPath) as? T {
            return reusable
        }
        return T()
    }
    
    func setupDynamicHeightCells() {
            self.contentInsetAdjustmentBehavior = .always
            (self.collectionViewLayout as? UICollectionViewFlowLayout)?
                .estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    }
}
