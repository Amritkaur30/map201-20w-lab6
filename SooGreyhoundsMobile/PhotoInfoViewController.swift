//
//  PhotoInfoViewController.swift
//  SooGreyhoundsMobile
//
//  Created by Amrit Kaur on 2020-01-30.
//  Copyright © 2020 Amrit Kaur. All rights reserved.
//

import UIKit
class PhotoInfoViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTags"?:
            let navController = segue.destination as! UINavigationController
            let tagController = navController.topViewController as! TagsViewController
            tagController.store = store
            tagController.photo = photo
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}
