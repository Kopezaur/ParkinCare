//
//  RDVSet.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/26/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation


class RDVSet : Sequence{
    
    /// number of elements in the set
    var count: Int{
        return RDVDAO.count
    }
    
    /// `RDVSet` x `RDV` -> `RDVSet` -- add RDV to RDVSet, if `RDV` already belongs to `RDVSet` then do nothing
    ///
    /// - Parameter RDV: `RDV` to be added to the set
    /// - Returns: `RDVSet` with new `RDV` added to the set, or `RDVSet` unmodified if `RDV` belonged already to the set.
    @discardableResult
    func add(rdv: RDV) -> RDVSet{
        if RDVDAO.count(rdv: rdv) > 1{
            CoreDataManager.context.delete(rdv)
        }
        else{
            RDVDAO.save()
        }
        return self
    }
    
    
    /// `RDVSet` x `RDV` -> `RDVSet` -- if `RDV` belongs to `RDVSet`, remove it from the set, else do nothing
    ///
    /// - Parameter RDV: `RDV` to be removed
    /// - Returns: `RDVSet` with `RDV` removed if `RDV` belonged to `RDVSet`
    @discardableResult
    func remove(rdv: RDV) -> RDVSet{
        while let p = RDVDAO.search(rdv: rdv){
            RDVDAO.delete(rdv: p)
        }
        RDVDAO.save()
        return self
    }
    
    /// `RDVSet` x `RDV` -> `[RDV]` --
    ///  looks for `RDV` with same firstname, lastname and bithdate
    ///
    /// - Parameter RDV: `RDV` to be looked for
    /// - Returns: RDV if there is one in set, else nil
    func look(forRDV rdv: RDV) -> RDV?{
        if let ret = RDVDAO.search(rdv: rdv){
            return ret
        }
        else{
            return nil
        }
    }
    
    /// `RDVSet` x `String` x `String` -> `Bool` -- look for `RDV` with these firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Parameter lastname: `String` lastname to be search
    /// - Returns: True if there is one `RDV` with these firstname and lastname
    func contains(rdvWithDateAndLocation dateTime: NSDate, location: String) -> Bool{
        return RDVDAO.count(dateTime: dateTime, location: location) > 0
    }
    
    /// `RDVSet` x `String` x `String` -> `[RDV]` --
    /// look into set for RDVs with this firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be looked for
    /// - Parameter lastname: `String` lastname to be looked for
    /// - Parameter birthdate: `Date?` Date if it has one, else nil
    /// - Returns: `RDV` will these firstname, lastname and birthdate given in parameter, or nil if it is not in set
    func look(rdvWithDateAndLocation dateTime: NSDate, location: String) -> [RDV]{
        if let ret = RDVDAO.search(dateTime: dateTime, location: location){
            return [ret]
        }
        else{
            return []
        }
    }
    
    /// `RDVSet` x `RDV` -> `Int?` --
    ///  returns index of the `RDV` in set with same firstname, lastname and birthdate
    ///
    /// - Parameter RDV: `RDV` with same firstname, lastname and birthdate as the one search
    /// - Returns: index of the `RDV` in set with same firstname, lastname and birthdate, or nil if it doesn't exist in set
    func indexOf(rdv: RDV) -> Int?{
        guard let set = RDVDAO.fetchAll() else { return nil }
        var i : Int = 0
        while i < set.count{
            if set[i] == rdv { return i }
            i += 1
        }
        return nil
    }
    
    subscript(index: Int) -> RDV{
        get{
            guard let set = RDVDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = RDVDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            RDVDAO.delete(rdv: set[index])
            set[index]  = newValue
            RDVDAO.save()
        }
    }
    
    /// `RDVSet` -> `ItRDVSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItRDVSet{
        return ItRDVSet(self)
    }
    
}

// MARK: -

/// Iterator on RDVSet
struct ItRDVSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [RDV]
    
    fileprivate init(_ s: RDVSet){
        if let set = RDVDAO.fetchAll(){
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
    mutating func reset() -> ItRDVSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> RDV? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextRDV = self.set[self.current]
        self.current += 1
        return nextRDV
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}


