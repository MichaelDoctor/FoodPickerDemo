//
//  FoodItem+CoreDataProperties.swift
//  FoodPickerDemo
//
//  Created by Michael Doctor on 2021-04-11.
//
//

import Foundation
import CoreData


extension FoodItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodItem> {
        return NSFetchRequest<FoodItem>(entityName: "FoodItem")
    }

    @NSManaged public var name: String?

}

extension FoodItem : Identifiable {

}
