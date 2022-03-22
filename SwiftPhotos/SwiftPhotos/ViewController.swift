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
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        
        let boundSize = UIScreen.main.bounds.size
        let frame = CGRect(x: 0, y: 0, width: boundSize.width, height: boundSize.height)
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        photosCollectionView.dataSource = self
        self.view.addSubview(photosCollectionView)
        photosCollectionView.register(PhotosCell.self, forCellWithReuseIdentifier: PhotosCell.photoCellName)
        self.title = "Photos"
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.photoCellName, for: indexPath)
        return cell
    }
}


