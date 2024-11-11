//
//  PHAssetCollection.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/5/21.
//

import UIKit
import Photos

extension PHAssetCollection {
    
    // MARK: - Public methods
    func getCoverImgWithSize(_ size: CGSize) -> UIImage! {
        let assets = PHAsset.fetchAssets(in: self, options: nil)
        let asset = assets.firstObject
        return asset?.getAssetThumbnail(size: size)
    }
    
    func hasAssets() -> Bool {
        let assets = PHAsset.fetchAssets(in: self, options: nil)
        return assets.count > 0
    }
    
}
