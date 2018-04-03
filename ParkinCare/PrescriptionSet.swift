//
//  PrescriptionSet.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/29/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

class PrescriptionSet : Sequence{
    //   fileprivate let request : NSFetchRequest<Prescription> = Prescription.fetchRequest()
    
    /// number of elements in the set
    var count: Int{
        return PrescriptionDAO.count
    }
    
    /// `PrescriptionSet` x `Prescription` -> `PrescriptionSet` -- add Prescription to PrescriptionSet, if `Prescription` already belongs to `PrescriptionSet` then do nothing
    ///
    /// - Parameter Prescription: `Prescription` to be added to the set
    /// - Returns: `PrescriptionSet` with new `Prescription` added to the set, or `PrescriptionSet` unmodified if `Prescription` belonged already to the set.
    @discardableResult
    func add(prescription: Prescription) -> PrescriptionSet{
        if PrescriptionDAO.count(prescription: prescription) > 1{
            CoreDataManager.context.delete(prescription)
        }
        else{
            PrescriptionDAO.save()
        }
        return self
    }
    
    
    /// `PrescriptionSet` x `Prescription` -> `PrescriptionSet` -- if `Prescription` belongs to `PrescriptionSet`, remove it from the set, else do nothing
    ///
    /// - Parameter Prescription: `Prescription` to be removed
    /// - Returns: `PrescriptionSet` with `Prescription` removed if `Prescription` belonged to `PrescriptionSet`
    @discardableResult
    func remove(prescription: Prescription) -> PrescriptionSet{
        while let p = PrescriptionDAO.search(prescription: prescription){
            PrescriptionDAO.delete(prescription: p)
        }
        PrescriptionDAO.save()
        return self
    }
    
    /// `PrescriptionSet` x `Prescription` -> `[Prescription]` --
    ///  looks for `Prescription` with same firstname, lastname and bithdate
    ///
    /// - Parameter Prescription: `Prescription` to be looked for
    /// - Returns: Prescription if there is one in set, else nil
    func look(forPrescription prescription: Prescription) -> Prescription?{
        if let ret = PrescriptionDAO.search(prescription: prescription){
            return ret
        }
        else{
            return nil
        }
    }
    
    /// `PrescriptionSet` x `String` x `String` -> `Bool` -- look for `Prescription` with these firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Parameter lastname: `String` lastname to be search
    /// - Returns: True if there is one `Prescription` with these firstname and lastname
    func contains(prescriptionWithDate dateTime: NSDate) -> Bool{
        return PrescriptionDAO.count(dateTime: dateTime) > 0
    }
    
    /// `PrescriptionSet` x `String` x `String` -> `[Prescription]` --
    /// look into set for Prescriptions with this firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be looked for
    /// - Parameter lastname: `String` lastname to be looked for
    /// - Parameter birthdate: `Date?` Date if it has one, else nil
    /// - Returns: `Prescription` will these firstname, lastname and birthdate given in parameter, or nil if it is not in set
    func look(prescriptionsWithDate dateTime: NSDate) -> [Prescription]{
        if let ret = PrescriptionDAO.search(dateTime: dateTime as Date){
            return ret
        }
        else{
            return []
        }
    }
    
    /// `PrescriptionSet` x `Prescription` -> `Int?` --
    ///  returns index of the `Prescription` in set with same firstname, lastname and birthdate
    ///
    /// - Parameter Prescription: `Prescription` with same firstname, lastname and birthdate as the one search
    /// - Returns: index of the `Prescription` in set with same firstname, lastname and birthdate, or nil if it doesn't exist in set
    func indexOf(prescription: Prescription) -> Int?{
        guard let set = PrescriptionDAO.fetchAll() else { return nil }
        var i : Int = 0
        while i < set.count{
            if set[i] == prescription { return i }
            i += 1
        }
        return nil
    }
    
    subscript(index: Int) -> Prescription{
        get{
            guard let set = PrescriptionDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = PrescriptionDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            PrescriptionDAO.delete(prescription: set[index])
            set[index]  = newValue
            PrescriptionDAO.save()
        }
    }
    
    /// `PrescriptionSet` -> `ItPrescriptionSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItPrescriptionSet{
        return ItPrescriptionSet(self)
    }
    
}

// MARK: -

/// Iterator on PrescriptionSet
struct ItPrescriptionSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Prescription]
    
    fileprivate init(_ s: PrescriptionSet){
        if let set = PrescriptionDAO.fetchAll(){
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
    mutating func reset() -> ItPrescriptionSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Prescription? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextPrescription = self.set[self.current]
        self.current += 1
        return nextPrescription
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}





