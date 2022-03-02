//
//  ProductViewCell.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit
import Kingfisher

protocol ProductViewCellDelegate: AnyObject {
    func productClicked(_ value: DetailModel)
}

class ProductViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var boxView: UIView!
    private weak var delegate: ProductViewCellDelegate?
    
    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.register(ProductCustomCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        boxView.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: boxView.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: boxView.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 0).isActive = true
    }
    
    private var products: [Product] = [Product]()
    
    override func bindData(_ data: Any?...) {
        
        guard data.count >= 1,
                let item = data.first as? HomeCellType,
                let targetDelegate = data[1] as? ProductViewCellDelegate else { return }
        
        delegate = targetDelegate
        
        switch item {
        case .product(let data):
            self.products = data
        default: break
        }
    }
}

extension ProductViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell", for: indexPath) as! ProductCustomCell
        cell.configure(with: self.products[indexPath.item].imageURL ?? "")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.productClicked(DetailModel(name: products[indexPath.item].name ?? "",
                                      desc: products[indexPath.item].productDescription ?? "",
                                      url: products[indexPath.item].imageURL ?? ""))
    }
}

class ProductCustomCell: BaseCollectionViewCell {
    
    fileprivate let boxView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .white
        return v
    }()
    
    fileprivate let icon: UIImageView = {
       let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .clear
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupShadow(color: .black,
                    radius: 0.8,
                    offsetWidth: 1,
                    offsetHeight: 4,
                    opacity: 0.4)
        
        contentView.addSubview(boxView)
        boxView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        boxView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        boxView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
        boxView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
        
        boxView.addSubview(icon)
        icon.topAnchor.constraint(equalTo: boxView.topAnchor, constant: 35).isActive = true
        icon.leftAnchor.constraint(equalTo: boxView.leftAnchor, constant: 35).isActive = true
        icon.rightAnchor.constraint(equalTo: boxView.rightAnchor, constant: -35).isActive = true
        icon.bottomAnchor.constraint(equalTo: boxView.bottomAnchor, constant: -35).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductCustomCell {
    public func configure(with bannerUrl: String) {
        let url = URL(string: bannerUrl)
        icon.kf.setImage(with: url)
    }
}
