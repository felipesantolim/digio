//
//  SpotlightViewCell.swift
//  Digio App
//
//  Created by Felipe Santolim on 01/03/22.
//

import UIKit
import Kingfisher

struct CarouselData {
    let banner: UIImageView?
    let row: Int?
}

protocol SpotlightViewCellDelegate: AnyObject {
    func spotlightClicked(_ value: DetailModel)
}

class SpotlightViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var boundariesView: UIView!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.delegate = self
            scrollView.isPagingEnabled = true
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = false }}
    
    @IBOutlet weak var pageControl: UIPageControl! {
        didSet { pageControl.currentPage = 0 }}
    
    private var counter: CGFloat = 0
    private var tagIndex: Int = 0
    private var data = [Spotlight]()
    private weak var delegate: SpotlightViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.boundariesView.layer.masksToBounds = false
        self.boundariesView.layer.shadowColor = UIColor.black.cgColor
        self.boundariesView.layer.cornerRadius = 0.8
        self.boundariesView.layer.shadowOffset = CGSize(width: 1, height: 4)
        self.boundariesView.layer.shadowOpacity = 0.4
    }
    
    override func bindData(_ data: Any?...) {
        
        guard data.count >= 1,
                let item = data.first as? HomeCellType,
                let targetDelegate = data[1] as? SpotlightViewCellDelegate else { return }
        
        delegate = targetDelegate
        
        switch item {
        case .spotlight(let item):
            self.data = item
            let data: [CarouselData] = item.enumerated().map { index, value in
                let tap = UITapGestureRecognizer(target: self, action: #selector(clicked))
                let url = URL(string: value.bannerURL ?? "")
                let img = UIImageView()
                img.isUserInteractionEnabled = true
                img.addGestureRecognizer(tap)
                img.kf.setImage(with: url)
                return CarouselData(banner: img, row: index)
            }
            self.setupScrollView(with: data)
            
        default:
            break
        }
    }
}

extension SpotlightViewCell {
    private func setupScrollView(with carouselData: [CarouselData]) {
        pageControl.numberOfPages = carouselData.count
        scrollView.contentSize = CGSize(
            width: boundariesView.frame.width * CGFloat(carouselData.count),
            height: boundariesView.frame.height)
        
        for item in carouselData {
            item.banner?.tag = item.row ?? 0
            item.banner?.contentMode = .scaleAspectFit
            item.banner?.frame = CGRect(x: scrollView.frame.width * CGFloat(counter),
                                        y: 0,
                                        width: scrollView.frame.width,
                                        height: scrollView.frame.height)
            
            scrollView.addSubview(item.banner ?? UIImageView())
            self.counter += 1
        }
    }
}

// MARK: UIScrollViewDelegate
extension SpotlightViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        self.pageControl.currentPage = Int(page)
    }
}

extension SpotlightViewCell {
    @objc func clicked() {
        delegate?.spotlightClicked(DetailModel(name: data[pageControl.currentPage].name,
                                      desc: data[pageControl.currentPage].spotlightDescription,
                                      url: data[pageControl.currentPage].bannerURL))
    }
}
