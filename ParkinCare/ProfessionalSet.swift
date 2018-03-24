//
//  ProfessionalSet.swift
//  ParkinCare
//
//  Created by Polytech Montpellier on 24/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

class ProfessionalSet : Sequence{
    //   fileprivate let request : NSFetchRequest<Professional> = Professional.fetchRequest()
    
    /// number of elements in the set
    var count: Int{
        return ProfessionalDAO.count
    }
    
    /// `ProfessionalSet` x `Professional` -> `ProfessionalSet` -- add Professional to ProfessionalSet, if `Professional` already belongs to `ProfessionalSet` then do nothing
    ///
    /// - Parameter Professional: `Professional` to be added to the set
    /// - Returns: `ProfessionalSet` with new `Professional` added to the set, or `ProfessionalSet` unmodified if `Professional` belonged already to the set.
    @discardableResult
    func add(professional: Professional) -> ProfessionalSet{
        if ProfessionalDAO.count(professional: professional) > 1{
            CoreDataManager.context.delete(professional)
        }
        else{
            ProfessionalDAO.save()
        }
        return self
    }
    
    
    /// `ProfessionalSet` x `Professional` -> `ProfessionalSet` -- if `Professional` belongs to `ProfessionalSet`, remove it from the set, else do nothing
    ///
    /// - Parameter Professional: `Professional` to be removed
    /// - Returns: `ProfessionalSet` with `Professional` removed if `Professional` belonged to `ProfessionalSet`
    @discardableResult
    func remove(professional: Professional) -> ProfessionalSet{
        while let p = ProfessionalDAO.search(professional: professional){
            ProfessionalDAO.delete(professional: p)
        }
        ProfessionalDAO.save()
        return self
    }
    
    /// `ProfessionalSet` x `Professional` -> `[Professional]` --
    ///  looks for `Professional` with same firstname, lastname and bithdate
    ///
    /// - Parameter Professional: `Professional` to be looked for
    /// - Returns: Professional if there is one in set, else nil
    func look(forProfessional professional: Professional) -> Professional?{
        if let ret = ProfessionalDAO.search(professional: professional){
            return ret
        }
        else{
            return nil
        }
    }
    
    /// `ProfessionalSet` x `String` x `String` -> `Bool` -- look for `Professional` with these firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Parameter lastname: `String` lastname to be search
    /// - Returns: True if there is one `Professional` with these firstname and lastname
    func contains(professionalWithFirstname firstname: String, lastname: String) -> Bool{
        return ProfessionalDAO.count(firstname: firstname, lastname: lastname) > 0
    }
    
    /// `ProfessionalSet` x `String` x `String` -> `[Professional]` --
    /// look into set for Professionals with this firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be looked for
    /// - Parameter lastname: `String` lastname to be looked for
    /// - Parameter birthdate: `Date?` Date if it has one, else nil
    /// - Returns: `Professional` will these firstname, lastname and birthdate given in parameter, or nil if it is not in set
    func look(professionalsWithFirstname firstname: String, lastname: String) -> [Professional]{
        if let ret = ProfessionalDAO.search(lastname: lastname, firstname: firstname){
            return [ret]
        }
        else{
            return []
        }
    }
    
    /// `ProfessionalSet` x `Professional` -> `Int?` --
    ///  returns index of the `Professional` in set with same firstname, lastname and birthdate
    ///
    /// - Parameter Professional: `Professional` with same firstname, lastname and birthdate as the one search
    /// - Returns: index of the `Professional` in set with same firstname, lastname and birthdate, or nil if it doesn't exist in set
    func indexOf(professional: Professional) -> Int?{
        guard let set = ProfessionalDAO.fetchAll() else { return nil }
        var i : Int = 0
        while i < set.count{
            if set[i] == professional { return i }
            i += 1
        }
        return nil
    }
    
    subscript(index: Int) -> Professional{
        get{
            guard let set = ProfessionalDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = ProfessionalDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            ProfessionalDAO.delete(professional: set[index])
            set[index]  = newValue
            ProfessionalDAO.save()
        }
    }
    
    /// `ProfessionalSet` -> `ItProfessionalSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItProfessionalSet{
        return ItProfessionalSet(self)
    }
    
}

// MARK: -

/// Iterator on ProfessionalSet
struct ItProfessionalSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Professional]
    
    fileprivate init(_ s: ProfessionalSet){
        if let set = ProfessionalDAO.fetchAll(){
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
    mutating func reset() -> ItProfessionalSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Professional? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextProfessional = self.set[self.current]
        self.current += 1
        return nextProfessional
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}
