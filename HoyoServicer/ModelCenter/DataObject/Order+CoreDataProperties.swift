//
//  Order+CoreDataProperties.swift
//  HoyoServicer
//
//  Created by 杨龙洲 on 28/4/16.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Order {

    @NSManaged var action: String?
    @NSManaged var city: String?
    @NSManaged var county: String?
    @NSManaged var id: String?
    @NSManaged var lat: String?
    @NSManaged var lng: String?
    @NSManaged var orderby: String?
    @NSManaged var pageindex: String?
    @NSManaged var pagesize: String?
    @NSManaged var province: String?

}
