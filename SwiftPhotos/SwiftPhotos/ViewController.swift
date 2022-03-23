//
//  ViewController.swift
//  SwiftPhotos
//
//  Created by Bibi on 2022/03/21.
//

import UIKit
import Photos

class ViewController: UIViewController {
    
    var allPhotos: PHFetchResult<PHAsset>!
    
    var photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.sectionInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
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
        
        self.allPhotos = PHAsset.fetchAssets(with: .image, options: nil) // 라이브러리에 있는 모든 사진 불러오기
        switch PHPhotoLibrary.authorizationStatus() {
            // 사용자가 접근을 허용했을 때
            case .authorized:
                // 옵저버로 등록
            PHPhotoLibrary.shared().register(self)
        default:
            return
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allPhotos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCell.photoCellName, for: indexPath) as? PhotosCell,
              let asset = self.allPhotos?.object(at: indexPath.item) else {
            return UICollectionViewCell()
        } // allPhotos에 indexPath.item의 위치에 있는 사진 하나의 Asset을 불러온다
        
        PHImageManager().requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (image, _) in
            cell.configure(with: image ?? UIImage()) // 불러온 사진 하나를 Cell에 넣어준다
        }
        
        return cell
    }
}
    
extension ViewController: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 변화 감지했을 때 원하는 동작 설정
        let changedPhotos = changeInstance.changeDetails(for: self.allPhotos)
        allPhotos = changedPhotos?.fetchResultAfterChanges
        DispatchQueue.main.async {
            self.photosCollectionView.insertItems(at: [IndexPath(item: self.allPhotos.count - 1, section: 0)])
        }

    }
}


