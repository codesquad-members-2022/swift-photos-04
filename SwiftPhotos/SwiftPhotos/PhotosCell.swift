//
//  PhotosCell.swift
//  SwiftPhotos
//
//  Created by 김한솔 on 2022/03/22.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    static let photoCellName = "PhotosCell"
    private var imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.contentView.addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        self.contentView.addSubview(imageView)
    }
    
    func configure(with image: UIImage) {
        self.imageView.image = image
    }
}
