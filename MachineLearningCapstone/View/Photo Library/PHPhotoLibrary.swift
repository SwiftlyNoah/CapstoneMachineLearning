//
//  PHPhotoLibrary.swift
//  MachineLearningCapstone
//
//  Created by Noah Brauner on 2/5/21.
//

import PhotosUI
import Photos

extension PHPhotoLibrary {
    
    // MARK: - Public methods
    static func checkAuthorizationStatus(completion: @escaping (_ status: Bool) -> Void) {
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            completion(true)
        }
        else {
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == PHAuthorizationStatus.authorized {
                    completion(true)
                }
                else {
                    completion(false)
                }
            }
        }
    }
}
