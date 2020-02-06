//
//  Photo+CoreDataProperties.swift
//  SooGreyhoundsMobile
//
//  Created by Amrit Kaur on 2020-02-06.
//  Copyright © 2020 Amrit Kaur. All rights reserved.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var photoID: String?
    @NSManaged public var title: String?
    @NSManaged public var dateTaken: NSDate?
    @NSManaged public var remoteURL: NSURL?

}
