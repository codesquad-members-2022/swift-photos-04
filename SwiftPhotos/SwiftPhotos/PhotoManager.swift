//
//  PhotoManager.swift
//  SwiftPhotos
//
//  Created by 김한솔 on 2022/03/24.
//

import Photos
import UIKit

class PhotoManager: NSObject {
    enum NotificationNames {
        static let didChangePhotos = Notification.Name("PhotoManagerDidChangePhotos")
    }
    
    private var photos: PHFetchResult<PHAsset>
    
    var count: Int {
        return self.photos.count
    }
    
    override init() {
        self.photos = PHAsset.fetchAssets(with: .image, options: nil)
        super.init()
        
        switch PHPhotoLibrary.authorizationStatus() {
            case .authorized:
                PHPhotoLibrary.shared().register(self)
            default:
                return
        }
    }
    
    func makePhotoData(index: Int, size: CGSize) -> UIImage? {
        let asset = self.photos.object(at: index)
        var photo: UIImage?
        
        PHCachingImageManager().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { (image, _) in
            photo = image
        }
        return photo
    }
}

extension PhotoManager: PHPhotoLibraryChangeObserver {
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
        let previousPhotos = self.photos
        let changedPhotos = changeInstance.changeDetails(for: previousPhotos)
        self.photos = changedPhotos?.fetchResultAfterChanges ?? previousPhotos
        
        NotificationCenter.default.post(name: NotificationNames.didChangePhotos, object: self)
    }
}
