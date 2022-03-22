//
//  ViewController.swift
//  SwiftPhotos
//
//  Created by Bibi on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {

    var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10 // 가로줄 여백
        layout.minimumInteritemSpacing = 10 // 세로줄 여백
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.estimatedItemSize = CGSize(width: 80, height: 80)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        let boundSize = UIScreen.main.bounds.size
        collectionView.frame = CGRect(x: 0, y: 0, width: boundSize.width, height: boundSize.height)
        
        return collectionView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.dataSource = self // delegate와 비슷
        self.view.addSubview(photosCollectionView)
        photosCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PhotosCell")
    }


}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
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

