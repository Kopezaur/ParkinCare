//
//  UserDAO.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/28/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation
import CoreData

class UserDAO{
    static let request : NSFetchRequest<User> = User.fetchRequest()
    
    static func save(){
        CoreDataManager.save()
    }
    static func delete(user: User){
        CoreDataManager.context.delete(user)
    }
//    static func fetchAll() -> [User]?{
//        self.request.predicate = nil
//        do{
//            request.sortDescriptors = [NSSortDescriptor(key:#keyPath(User.lastname.localizedUppercase),ascending:true),NSSortDescriptor(key:#keyPath(User.firstname.localizedUppercase),ascending:true)]
//            return try CoreDataManager.context.fetch(self.request)
//        }
//        catch{
//            return nil
//        }
//    }
    
    /// number of elements
    static var count: Int{
        self.request.predicate = nil
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static private func createUser() -> User{
        return User(context: CoreDataManager.context)
    }
    
    static func createUser(lastname: String, firstname: String, email: String, numTel:String, address: String) -> User{
        let dao        = self.createUser()
        dao.lastname  = lastname
        dao.firstname = firstname
        dao.email = email
        dao.numTel = numTel
        dao.address = address
        return dao
    }
    
    static func createUser(user :User) -> User{
        let dao        = self.createUser()
        dao.lastname  = user.lastname
        dao.firstname = user.firstname
        dao.email = user.email
        dao.numTel = user.numTel
        dao.address = user.address
        return dao
    }
    
    static func count(firstname: String, lastname: String) -> Int{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", firstname, lastname)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func count(user: User) -> Int{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", user.firstname!, user.lastname!)
        do{
            return try CoreDataManager.context.count(for: self.request)
        }
        catch let error as NSError{
            fatalError(error.description)
        }
    }
    
    static func search(user: User) -> User?{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", user.firstname!, user.lastname!)
        do{
            let result = try CoreDataManager.context.fetch(request) as [User]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func search(lastname: String, firstname: String) -> User?{
        self.request.predicate = NSPredicate(format: "firstname == %@ AND lastname == %@", firstname, lastname)
        do{
            let result = try CoreDataManager.context.fetch(request) as [User]
            guard result.count != 0 else { return nil }
            return result[0]
        }
        catch{
            return nil
        }
    }
    
    static func add(user: User){
        if let _ = self.search(user: user){} else{
            let _ = self.createUser(user: user)
            self.save()
        }
    }
}





