//
//  PhotosViewController.swift
//  SooGreyhoundsMobile
//
//  Created by Amrit Kaur on 2020-01-23.
//  Copyright © 2020 Amrit Kaur. All rights reserved.
//

import UIKit
class PhotosViewController: UIViewController,UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView!
     var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
   
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        store.fetchLatestPhotos {
            (photosResult) -> Void in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos.")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching latest photos: \(error)")
                self.photoDataSource.photos.removeAll()
            }
            OperationQueue.main.addOperation {
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
            
        }
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        // Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            // (Note: You will have an error on the next line; you will fix it soon)
            guard let photoIndex = self.photoDataSource.photos.index(of: photo),
                case let .success(image) = result else {
                    return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            // When the request finishes, only update the cell if it's still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath)
                as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath =
                collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    }

