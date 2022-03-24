//
//  ViewController.swift
//  SwiftPhotos
//
//  Created by Bibi on 2022/03/21.
//

import UIKit

class ViewController: UIViewController {
    
    enum Constants {
        static let cellWidth = 100
        static let cellHeight = 100
        static let cellSpace = 3.0
        static let lineSpace = 1.0
    }
    
    var photoManager = PhotoManager()
    
    var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = Constants.lineSpace
        layout.minimumInteritemSpacing = Constants.lineSpace
        layout.sectionInset = UIEdgeInsets(top: Constants.cellSpace, left: Constants.cellSpace,
                                           bottom: Constants.cellSpace, right: Constants.cellSpace)
        layout.estimatedItemSize = CGSize(width: Constants.cellWidth, height: Constants.cellHeight)
        
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(), name: PhotoManager.NotificationNames.didChangePhotos, object: self.photoManager)
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photoManager.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.photoCellName, for: indexPath) as? PhotosCell else {
            return UICollectionViewCell()
        }
        
        let photoData = self.photoManager.makePhotoData(index: indexPath.item, size: CGSize(width: Constants.cellWidth, height: Constants.cellHeight))
        
        cell.configure(with: UIImage(data: photoData ?? Data()) ?? UIImage())
        return cell
    }
}
    
//extension ViewController: PHPhotoLibraryChangeObserver {
//    func photoLibraryDidChange(_ changeInstance: PHChange) {
//        let changedPhotos = changeInstance.changeDetails(for: self.allPhotos)
//        allPhotos = changedPhotos?.fetchResultAfterChanges
//        DispatchQueue.main.async {
//            self.photosCollectionView.insertItems(at: [IndexPath(item: self.allPhotos.count - 1, section: 0)])
//        }
//
//    }
//}


