//  Book+CoreDataProperties.swift
//  Library


import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var title: String?
    @NSManaged public var isbn: String?
    @NSManaged public var authors: Author?

}
