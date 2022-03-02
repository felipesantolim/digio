//
//  CashViewCell.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit
import Kingfisher

protocol CashViewCellDelegate: AnyObject {
    func cashClicked(_ value: DetailModel)
}

class CashViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var banner: UIImageView!
    private var data: Cash?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.banner.layer.masksToBounds = false
        self.banner.layer.shadowColor = UIColor.black.cgColor
        self.banner.layer.cornerRadius = 0.8
        self.banner.layer.shadowOffset = CGSize(width: 1, height: 4)
        self.banner.layer.shadowOpacity = 0.4
    }
    private weak var delegate: CashViewCellDelegate?
    
    override func bindData(_ data: Any?...) {
        
        guard data.count >= 1,
                let item = data.first as? HomeCellType,
                let targetDelegate = data[1] as? CashViewCellDelegate else { return }
        
        delegate = targetDelegate
        
        switch item {
        case .cash(let item):
            self.data = item
            let tap = UITapGestureRecognizer(target: self, action: #selector(clicked))
            let url = URL(string: item.bannerURL ?? "")
            self.banner.isUserInteractionEnabled = true
            self.banner.addGestureRecognizer(tap)
            self.banner.kf.setImage(with: url)
        default:
            break
        }
    }
}

extension CashViewCell {
    @objc func clicked() {
        delegate?.cashClicked(DetailModel(name: data?.title ?? "",
                                      desc: data?.cashDescription ?? "",
                                      url: data?.bannerURL ?? ""))
    }
}
