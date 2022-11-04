//
//  CoreDataService.swift
//  FindMyTool
//
//  Created by Nicolas Demange on 04/11/2022.
//

import Foundation
import CoreData


final class CoreDataService {
    
    // MARK: - Properties
    
    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext
    
    // Read
    var toolsFavorite: [ToolEntity] {
        // fetch all entities "Tool" :
        let request: NSFetchRequest<ToolEntity> = ToolEntity.fetchRequest()
        
        // sort favorites
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // execute request
        guard let toolsFav = try? managedObjectContext.fetch(request) else { return [] }
        
        return toolsFav
    }
    
    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }
    
    // MARK: - Manage Tool Entity
    
    func createFavoriteTool(tool: Tool) {
        let toolEntity = ToolEntity(context: managedObjectContext)
        
        toolEntity.name = tool.name
        toolEntity.price = tool.price
        toolEntity.town = tool.town
        toolEntity.postalCode = tool.postalCode
        toolEntity.detail = tool.description
        toolEntity.image = tool.imageLink
        
        coreDataStack.saveContext()
    }
    
    func isToolRegistered(name: String) -> Bool {
        let request: NSFetchRequest<ToolEntity> = ToolEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        guard let favoritesTool = try? managedObjectContext.fetch(request) else { return false }
        
        if favoritesTool.isEmpty
        { return false }
        return true
    }
    
    func deleteTool(name: String) {
        let request: NSFetchRequest<ToolEntity> = ToolEntity.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        
        guard let favoritesTool = try? managedObjectContext.fetch(request) else { return }
        guard let tool = favoritesTool.first else
        { return }
        managedObjectContext.delete(tool)
        coreDataStack.saveContext()
    }
    
}
