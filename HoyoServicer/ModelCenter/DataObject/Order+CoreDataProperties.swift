//
//  Order+CoreDataProperties.swift
//  HoyoServicer
//
//  Created by 赵兵 on 16/4/18.
//  Copyright © 2016年 com.ozner.net. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Order {

    @NSManaged var orderId: String?
    @NSManaged var userId: String?

}
