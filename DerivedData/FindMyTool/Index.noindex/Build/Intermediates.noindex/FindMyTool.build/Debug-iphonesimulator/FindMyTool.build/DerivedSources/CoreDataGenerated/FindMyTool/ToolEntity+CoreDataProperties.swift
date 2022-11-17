//
//  ToolEntity+CoreDataProperties.swift
//  
//
//  Created by Nicolas Demange on 04/11/2022.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension ToolEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToolEntity> {
        return NSFetchRequest<ToolEntity>(entityName: "ToolEntity")
    }

    @NSManaged public var detail: String?
    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var price: String?
    @NSManaged public var town: String?

}

extension ToolEntity : Identifiable {

}
