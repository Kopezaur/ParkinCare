//
//  DoseSet.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/27/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation


class DoseSet : Sequence{
    
    /// number of elements in the set
    var count: Int{
        return DoseDAO.count
    }
    
    /// `DoseSet` x `Dose` -> `DoseSet` -- add Dose to DoseSet, if `Dose` already belongs to `DoseSet` then do nothing
    ///
    /// - Parameter Dose: `Dose` to be added to the set
    /// - Returns: `DoseSet` with new `Dose` added to the set, or `DoseSet` unmodified if `Dose` belonged already to the set.
    @discardableResult
    func add(dose: Dose) -> DoseSet{
        if DoseDAO.count(dose: dose) > 1{
            CoreDataManager.context.delete(dose)
        }
        else{
            DoseDAO.save()
        }
        return self
    }
    
    
    /// `DoseSet` x `Dose` -> `DoseSet` -- if `Dose` belongs to `DoseSet`, remove it from the set, else do nothing
    ///
    /// - Parameter Dose: `Dose` to be removed
    /// - Returns: `DoseSet` with `Dose` removed if `Dose` belonged to `DoseSet`
    @discardableResult
    func remove(dose: Dose) -> DoseSet{
        while let d = DoseDAO.search(dose: dose){
            DoseDAO.delete(dose: d)
        }
        DoseDAO.save()
        return self
    }
    
    /// `DoseSet` x `Dose` -> `[Dose]` --
    ///  looks for `Dose` with same firstname, lastname and bithdate
    ///
    /// - Parameter Dose: `Dose` to be looked for
    /// - Returns: Dose if there is one in set, else nil
    func look(forDose dose: Dose) -> Dose?{
        if let ret = DoseDAO.search(dose: dose){
            return ret
        }
        else{
            return nil
        }
    }
    
    /// `DoseSet` x `String` x `String` -> `Bool` -- look for `Dose` with these firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Parameter lastname: `String` lastname to be search
    /// - Returns: True if there is one `Dose` with these firstname and lastname
    func contains(doseWithNameAndQuantity medName: String, quantity: Int16) -> Bool{
        return DoseDAO.count(medName: medName, quantity: quantity) > 0
    }
    
    /// `DoseSet` x `String` x `String` -> `[Dose]` --
    /// look into set for Doses with this firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be looked for
    /// - Parameter lastname: `String` lastname to be looked for
    /// - Parameter birthdate: `Date?` Date if it has one, else nil
    /// - Returns: `Dose` will these firstname, lastname and birthdate given in parameter, or nil if it is not in set
    /*func look(doseWithDateAndLocation dateTime: NSDate, location: String) -> [Dose]{
     if let ret = DoseDAO.search(dateTime: dateTime, location: location){
     return [ret]
     }
     else{
     return []
     }
     }*/
    
    /// `DoseSet` x `Dose` -> `Int?` --
    ///  returns index of the `Dose` in set with same firstname, lastname and birthdate
    ///
    /// - Parameter Dose: `Dose` with same firstname, lastname and birthdate as the one search
    /// - Returns: index of the `Dose` in set with same firstname, lastname and birthdate, or nil if it doesn't exist in set
    func indexOf(dose: Dose) -> Int?{
        guard let set = DoseDAO.fetchAll() else { return nil }
        var i : Int = 0
        while i < set.count{
            if set[i] == dose { return i }
            i += 1
        }
        return nil
    }
    
    subscript(index: Int) -> Dose{
        get{
            guard let set = DoseDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = DoseDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            DoseDAO.delete(dose: set[index])
            set[index]  = newValue
            DoseDAO.save()
        }
    }
    
    /// `DoseSet` -> `ItDoseSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItDoseSet{
        return ItDoseSet(self)
    }
    
}

// MARK: -

/// Iterator on DoseSet
struct ItDoseSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Dose]
    
    fileprivate init(_ s: DoseSet){
        if let set = DoseDAO.fetchAll(){
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
    mutating func reset() -> ItDoseSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Dose? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextDose = self.set[self.current]
        self.current += 1
        return nextDose
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}




