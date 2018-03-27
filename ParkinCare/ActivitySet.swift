//
//  ActivitySet.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

class ActivitySet : Sequence{
    //   fileprivate let request : NSFetchRequest<Activity> = Activity.fetchRequest()
    
    /// number of elements in the set
    var count: Int{
        return ActivityDAO.count
    }
    
    /// `ActivitySet` x `Activity` -> `ActivitySet` -- add Activity to ActivitySet, if `Activity` already belongs to `ActivitySet` then do nothing
    ///
    /// - Parameter Activity: `Activity` to be added to the set
    /// - Returns: `ActivitySet` with new `Activity` added to the set, or `ActivitySet` unmodified if `Activity` belonged already to the set.
    @discardableResult
    func add(activity: Activity) -> ActivitySet{
        if ActivityDAO.count(activity: activity) > 1{
            CoreDataManager.context.delete(activity)
        }
        else{
            ActivityDAO.save()
        }
        return self
    }
    
    
    /// `ActivitySet` x `Activity` -> `ActivitySet` -- if `Activity` belongs to `ActivitySet`, remove it from the set, else do nothing
    ///
    /// - Parameter Activity: `Activity` to be removed
    /// - Returns: `ActivitySet` with `Activity` removed if `Activity` belonged to `ActivitySet`
    @discardableResult
    func remove(activity: Activity) -> ActivitySet{
        while let p = ActivityDAO.search(activity: activity){
            ActivityDAO.delete(activity: p)
        }
        ActivityDAO.save()
        return self
    }
    
    /// `ActivitySet` x `Activity` -> `[Activity]` --
    ///  looks for `Activity` with same firstname, lastname and bithdate
    ///
    /// - Parameter Activity: `Activity` to be looked for
    /// - Returns: Activity if there is one in set, else nil
    func look(forActivity activity: Activity) -> Activity?{
        if let ret = ActivityDAO.search(activity: activity){
            return ret
        }
        else{
            return nil
        }
    }
    
    /// `ActivitySet` x `String` x `String` -> `Bool` -- look for `Activity` with these firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Parameter lastname: `String` lastname to be search
    /// - Returns: True if there is one `Activity` with these firstname and lastname
    func contains(activityWithTitle title: String) -> Bool{
        return ActivityDAO.count(title: title) > 0
    }
    
    /// `ActivitySet` x `String` x `String` -> `[Activity]` --
    /// look into set for Activitys with this firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be looked for
    /// - Parameter lastname: `String` lastname to be looked for
    /// - Parameter birthdate: `Date?` Date if it has one, else nil
    /// - Returns: `Activity` will these firstname, lastname and birthdate given in parameter, or nil if it is not in set
    func look(activitiesWithTitle title: String) -> [Activity]{
        if let ret = ActivityDAO.search(title: title){
            return [ret]
        }
        else{
            return []
        }
    }
    
    /// `ActivitySet` x `Activity` -> `Int?` --
    ///  returns index of the `Activity` in set with same firstname, lastname and birthdate
    ///
    /// - Parameter Activity: `Activity` with same firstname, lastname and birthdate as the one search
    /// - Returns: index of the `Activity` in set with same firstname, lastname and birthdate, or nil if it doesn't exist in set
    func indexOf(activity: Activity) -> Int?{
        guard let set = ActivityDAO.fetchAll() else { return nil }
        var i : Int = 0
        while i < set.count{
            if set[i] == activity { return i }
            i += 1
        }
        return nil
    }
    
    subscript(index: Int) -> Activity{
        get{
            guard let set = ActivityDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = ActivityDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            ActivityDAO.delete(activity: set[index])
            set[index]  = newValue
            ActivityDAO.save()
        }
    }
    
    /// `ActivitySet` -> `ItActivitySet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItActivitySet{
        return ItActivitySet(self)
    }
    
}

// MARK: -

/// Iterator on ActivitySet
struct ItActivitySet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Activity]
    
    fileprivate init(_ s: ActivitySet){
        if let set = ActivityDAO.fetchAll(){
            self.set = set
        }
        else{
            self.set = []
        }
    }
    
    /// reset iterator
    ///
    /// - Returns: iterator reseted
    @discardableResult
    mutating func reset() -> ItActivitySet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Activity? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextActivity = self.set[self.current]
        self.current += 1
        return nextActivity
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}



