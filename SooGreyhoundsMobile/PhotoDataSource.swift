//
//  PhotoDataSource.swift
//  SooGreyhoundsMobile
//
//  Created by Amrit Kaur on 2020-01-30.
//  Copyright © 2020 Amrit Kaur. All rights reserved.
//

import UIKit
class PhotoDataSource: NSObject, UICollectionViewDataSource {
    var photos = [Photo]()
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for:
            indexPath)as! PhotoCollectionViewCell
        return cell
    }
}
