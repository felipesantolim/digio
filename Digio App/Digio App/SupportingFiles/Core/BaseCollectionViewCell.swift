//
//  BaseCollectionViewCell.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit
import RxSwift
import RxCocoa

open class BaseCollectionViewCell: UICollectionViewCell {
    
    open func bindData(_ data: Any?...) {}
    
    open func setupShadow(color: UIColor,
                     radius: CGFloat,
                     offsetWidth: Int,
                     offsetHeight: Int,
                     opacity: Float) {
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.cornerRadius = radius
        self.layer.shadowOffset = CGSize(width: offsetWidth,
                                         height: offsetHeight)
        self.layer.shadowOpacity = opacity
    }
}
