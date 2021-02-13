//
//  PhotoCVC.swift
//  iOS-api-test
//
//  Created by taehy.k on 2021/02/08.
//

import UIKit

import Kingfisher

class PhotoCVC: UICollectionViewCell {
    static let identifier = "PhotoCVC"
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        imageView.layer.cornerRadius = 10
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    func configure(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        DispatchQueue.main.async {
            self.imageView.kf.indicatorType = .activity
            self.imageView.kf.setImage(with: url, placeholder: nil, options: [.transition(.fade(0.7))], progressBlock: nil)
        }
    }
}
