//
//  ProfessionalSet.swift
//  ParkinCare
//
//  Created by Fabien TURGUT on 20/03/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import UIKit

class ProfessionalSetModel: Sequence{
    
    fileprivate var professionals : [ProfessionalModel] = []
    
    /// `ProfessionalSetModel` x `ProfessionalModel` -> `ProfessionalSetModel` -- add ProfessionalModel to ProfessionalSetModel, if `ProfessionalModel` already belongs to `ProfessionalSetModel` then do nothing
    ///
    /// - Parameter person: `ProfessionalModel` to be added to the set
    /// - Returns: `ProfessionalSetModel` with new `ProfessionalModel` added to the set, or `ProfessionalSetModel` unmodified if `ProfessionalModel` belonged already to the set.
    @discardableResult
    func add(professional: ProfessionalModel) -> ProfessionalSetModel{
        if !self.contains(professional: professional){
            self.professionals.append(professional)
        }
        return self
    }
    
    /// `ProfessionalSetModel` x `ProfessionalModel` -> `ProfessionalSetModel` -- if `ProfessionalModel` belongs to `ProfessionalSetModel`, remove it from the set, else do nothing
    ///
    /// - Parameter person: `ProfessionalModel` to be removed
    /// - Returns: `ProfessionalSetModel` with `ProfessionalModel` removed if `ProfessionalModel` belonged to `ProfessionalSetModel`
    @discardableResult
    func remove(professional: ProfessionalModel) -> ProfessionalSetModel{
        if let i = self.professionals.index(of: professional){
            self.professionals.remove(at: i)
        }
        return self
    }
    
    /// Number of elements in the set
    var count: Int{
        return self.professionals.count
    }
    
    // - MARK: - Search functions -
    
    /// `ProfessionalSetModel` x `ProfessionalModel` -> `Bool` -- look for `ProfessionalModel` in the set...
    ///
    /// - Parameter person: `ProfessionalModel` to be looked for
    /// - Returns: True if `ProfessionalModel` belongs to the set
    func contains(professional: ProfessionalModel) -> Bool{
        return self.professionals.contains(where: {$0===professional})
    }
    
    /// `ProfessionalSetModel` x `ProfessionalModel` -> `ProfessionalSetModel` --
    ///  looks for `ProfessionalModel` with same firstname, lastname and returns a Set of all these persons
    ///
    /// - Parameter person: `ProfessionalModel` to be looked for
    /// - Returns: ProfessionalSetModel will return all `ProfessionalModel` conforming to parameter
    func look(forProfessionals professional: ProfessionalModel) -> ProfessionalSetModel{
        let ret : ProfessionalSetModel = ProfessionalSetModel()
        for p in self{
            if( (p.firstname == professional.firstname) && (p.lastname == professional.lastname) ){
                ret.add(professional: p)
            }
        }
        return ret
    }
    
    /// `ProfessionalSetModel` x `String` -> `Bool` -- look for `ProfessionalModel` with firstname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Returns: True if at least one `ProfessionalModel` has this firstname
    func contains(professionalWithFirstname firstname: String) -> Bool{
        return self.professionals.contains(where: {$0.firstname==firstname})
    }
    
    /// `ProfessionalSetModel` x `ProfessionalModel` -> `ProfessionalSetModel` --
    ///  looks for `ProfessionalModel` with a particular first name and returns a Set of all these persons
    ///
    /// - Parameter firstname: `String` first name to be looked for
    /// - Returns: ProfessionalSetModel will return all `ProfessionalModel` with first name given in parameter
    func look(forProfessionalsWithFirstname firstname: String) -> ProfessionalSetModel{
        let ret : ProfessionalSetModel = ProfessionalSetModel()
        for p in self{
            if( p.firstname == firstname ){
                ret.add(professional: p)
            }
        }
        return ret
    }

    
    /// `ProfessionalSetModel` x `String` -> `Bool` -- look for `ProfessionalModel` with lastname
    ///
    /// - Parameter fullname: `String` fullname to be search
    /// - Returns: True if at least one `ProfessionalModel` has this fullname
    func contains(professionalWithFullname fullname: String) -> Bool{
        return self.professionals.contains(where: {$0.fullname==fullname})
    }
    
    /// `ProfessionalSetModel` x `ProfessionalModel` -> `ProfessionalSetModel` --
    ///  looks for `ProfessionalModel` with a particular full name and returns a Set of all these persons
    ///
    /// - Parameter fullname: `String` full name to be looked for
    /// - Returns: ProfessionalSetModel will return all `ProfessionalModel` with full name given in parameter
    func look(forProfessionalsWithFullname fullname: String) -> ProfessionalSetModel{
        let ret : ProfessionalSetModel = ProfessionalSetModel()
        for p in self{
            if( p.fullname == fullname ){
                ret.add(professional: p)
            }
        }
        return ret
    }
    
    // MARK: - Iterator functions -
    
    subscript(index: Int) -> ProfessionalModel {
        get {
            guard (index>=0) && (index<self.professionals.count) else{
                fatalError("index out of range")
            }
            return self.professionals[index]
        }
        set(newValue) {
            guard (index>=0) && (index<self.professionals.count) else{
                fatalError("index out of range")
            }
            self.professionals[index]=newValue
        }
    }
    
    /// `ProfessionalSetModel` -> `ItProfessionalSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItProfessionalSet{
        return ItProfessionalSet(self)
    }
    
    // MARK: - Depreciated functions-
    
    init(){
//        self.professionals = [ProfessionalModel(firstname:"Patrick", lastname:"Bruel", title:"Dentiste", address:"hopital", email:"f@f.f", numTel:"05142345", organization:"orgnisation")]
        self.professionals = Professional.getAll()
    }
    
    func getAll() -> [ProfessionalModel]{
        return self.professionals
    }
    
    func addProfessional(professional : ProfessionalModel){
        self.professionals.append(professional)
        //TO DO
    }
}

// MARK: - ProfessionalSetIterator

/// Iterator on ProfessionalSetModel
struct ItProfessionalSet : IteratorProtocol{
    private var current: Int = 0
    private let set: ProfessionalSetModel
    
    fileprivate init(_ s: ProfessionalSetModel){
        self.set = s
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
    mutating func next() -> ProfessionalModel? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextObject = self.set.professionals[self.current]
        self.current += 1
        return nextObject
    }
    
    /// true if iterator has finished
    var end : Bool{
        return self.current < self.set.count
    }
}
