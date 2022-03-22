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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        var imageView: UIImageView {
            let imageView = UIImageView()
            imageView.backgroundColor = UIColor.randomColor()
            imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
            return imageView
        }
        self.contentView.addSubview(imageView)
    }
}

extension UIColor {
    static fileprivate func randomColor() -> UIColor {
        let r = CGFloat(Int.random(in: 0...255)) / 255
        let g = CGFloat(Int.random(in: 0...255)) / 255
        let b = CGFloat(Int.random(in: 0...255)) / 255
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}
