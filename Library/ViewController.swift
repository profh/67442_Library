//  ViewController.swift
//  Library

import Foundation
import CoreData
import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var booksList: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    insertAuthorAndSetLabel()
    insertBooksAndUpdateBookList()
  }
  
  func insertAuthorAndSetLabel(){
    
    // insert start here
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    // create Author object
    let author = Author(context: context)
    author.firstName = "William"
    author.lastName = "Shakespeare"
    
    // save data in store
    appDelegate.saveContext()
    
    // insert ends here
    
    
    // fetch data from core data to get value
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Author")

    
    do{
      let res = try context.fetch(request)  //array of object [Author]
      
      let fetchedAuthor = res.first as? Author   // let fetchedAuthor = Author
      print(fetchedAuthor?.firstName ?? "")
      print(fetchedAuthor?.lastName ?? "")
      
      nameLabel.text = fetchedAuthor!.firstName! + " " + fetchedAuthor!.lastName!
      
    }catch let error{
      print(error)
    }
    
  }
  
  func insertBooksAndUpdateBookList(){
    
    // insert start here
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    // create Author object
    let author = Author(context: context)
    author.firstName = "William"
    author.lastName = "Shakespeare"
    
    // create Book objects
    let b1 = Book(context : context)
    b1.title = "King Lear"
    b1.isbn = "11223344X"
    
    let b2 = Book(context : context)
    b2.title = "Hamlet"
    b2.isbn = "55667788Z"
    
    let b3 = Book(context : context)
    b3.title = "Macbeth"
    b3.isbn = "99110033W"
    
    
    // create relationships using Xcode generated methods
    author.addToBooks(b1)
    author.addToBooks(b2)
    
    
    appDelegate.saveContext()
    // insert ends here
    
    // fetch data from core data to get value
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Author")
    
    do{
      let res = try context.fetch(request)
      
      var anArray = [String]()
      
      // fetch result can have more than one person objects
      for anAuthor in res {
        
        let obj = anAuthor as! Author
        
        // an author can have more than one book
        for item in obj.books!
        {
          let a = item as! Book
          let bookTitle = a.title
          anArray.append(bookTitle!)
        }
      }
      
      print(anArray.debugDescription)
      
      booksList.text = ("One to many example\nAuthor: \(author.firstName ?? "") \(author.lastName ?? "")\n \(anArray.description)")
      
    }catch let error{
      print(error)
    }
    
  }


}

