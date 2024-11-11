//
//  PHAsset.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/5/21.
//

import PhotosUI
import Photos

extension PHAsset {
    
    // MARK: - Public methods
    func getAssetThumbnail(size: CGSize) -> UIImage {
        
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.isSynchronous = true
        
        var thumbnail = UIImage()
        
        manager.requestImage(for: self,
                             targetSize: size,
                             contentMode: .aspectFill,
                             options: option) { result, _ in
            thumbnail = result!
        }
        
        return thumbnail
    }
    
    func getOrginalImage(completion: @escaping (UIImage) -> Void) {
        
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        
        var image = UIImage()
        
        manager.requestImage(for: self,
                             targetSize: PHImageManagerMaximumSize,
                             contentMode: .default,
                             options: option)  { result, _ in
            image = result!
            
            completion(image)
        }
    }
    
    func getImageFromPHAsset() -> UIImage {
        var image = UIImage()
        
        let requestOptions = PHImageRequestOptions()
        requestOptions.resizeMode = PHImageRequestOptionsResizeMode.exact
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryMode.highQualityFormat
        requestOptions.isSynchronous = true
        
        if self.mediaType == PHAssetMediaType.image {
            PHImageManager.default().requestImage(for: self,
                                                  targetSize: PHImageManagerMaximumSize,
                                                  contentMode: .default,
                                                  options: requestOptions) { pickedImage, _ in
                image = pickedImage!
            }
        }
        return image
    }
}
