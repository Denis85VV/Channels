import UIKit
import CoreData

final class CoreDataHandler: NSObject {
  
  private func getContext() -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
  }
  
  func saveItem(id: Int) {
    let context = getContext()
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
    guard let entity = NSEntityDescription.entity(forEntityName: Constants.entityId, in: context) else { return }
    let channel = NSManagedObject(entity: entity, insertInto: context)
    
    channel.setValue(id, forKey: Constants.attributeId)
    
    do {
      try context.save()
    } catch let error as NSError {
      print("Failed: \(error), \(error.userInfo)")
    }
  }
  
  func fetchItems() -> [NSManagedObject] {
    let context = getContext()
    var fetchList: [NSManagedObject] = []
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: Constants.entityId)
   
    do {
      fetchList = try context.fetch(fetchRequest)
    } catch let error as NSError {
      print("Failed: \(error), \(error.userInfo)")
    }
    return fetchList
  }
  
  func fetchIntItems() -> [Int] {
    let fetchItems = fetchItems()
    let intItems = fetchItems.map { $0.value(forKey: Constants.attributeId) as! Int }
    return intItems
  }
  
  func deleteItem(id: Int) {
    let context = getContext()
    let data = fetchItems().filter {
      $0.value(forKey: Constants.attributeId) as! Int == id
    }
    
    guard let item = data.first else { return }
    context.delete(item)
    
    do {
      try context.save()
    } catch let error as NSError {
      print("Failed: \(error), \(error.userInfo)")
    }
  }
  
  func deleteAllItems() {
    let context = getContext()
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Channels")
    let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
    
    do {
      try context.execute(deleteRequest)
    } catch let error as NSError {
      print("Failed: \(error), \(error.userInfo)")
    }
  }
}

private extension CoreDataHandler {
  enum Constants {
    static let entityId: String = "Channels"
    static let attributeId: String = "channelId"
  }
}
