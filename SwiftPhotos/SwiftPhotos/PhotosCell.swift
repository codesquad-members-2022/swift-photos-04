//
//  PhotosCell.swift
//  SwiftPhotos
//
//  Created by 김한솔 on 2022/03/22.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    static var photoCellName = "PhotosCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configure(with image: UIImage) {
        var imageView: UIImageView {
            let imageView = UIImageView()
            imageView.image = image
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            return imageView
        }
        self.contentView.addSubview(imageView)
    }
}
