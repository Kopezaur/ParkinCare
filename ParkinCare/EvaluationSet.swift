//
//  EvaluationSet.swift
//  ParkinCare
//
//  Created by Kopezaur on 3/29/18.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import Foundation

class EvaluationSet : Sequence{
    //   fileprivate let request : NSFetchRequest<Evaluation> = Evaluation.fetchRequest()
    
    /// number of elements in the set
    var count: Int{
        return EvaluationDAO.count
    }
    
    /// `EvaluationSet` x `Evaluation` -> `EvaluationSet` -- add Evaluation to EvaluationSet, if `Evaluation` already belongs to `EvaluationSet` then do nothing
    ///
    /// - Parameter Evaluation: `Evaluation` to be added to the set
    /// - Returns: `EvaluationSet` with new `Evaluation` added to the set, or `EvaluationSet` unmodified if `Evaluation` belonged already to the set.
    @discardableResult
    func add(evaluation: Evaluation) -> EvaluationSet{
        if EvaluationDAO.count(evaluation: evaluation) > 1{
            CoreDataManager.context.delete(evaluation)
        }
        else{
            EvaluationDAO.save()
        }
        return self
    }
    
    
    /// `EvaluationSet` x `Evaluation` -> `EvaluationSet` -- if `Evaluation` belongs to `EvaluationSet`, remove it from the set, else do nothing
    ///
    /// - Parameter Evaluation: `Evaluation` to be removed
    /// - Returns: `EvaluationSet` with `Evaluation` removed if `Evaluation` belonged to `EvaluationSet`
    @discardableResult
    func remove(evaluation: Evaluation) -> EvaluationSet{
        while let p = EvaluationDAO.search(evaluation: evaluation){
            EvaluationDAO.delete(evaluation: p)
        }
        EvaluationDAO.save()
        return self
    }
    
    /// `EvaluationSet` x `Evaluation` -> `[Evaluation]` --
    ///  looks for `Evaluation` with same firstname, lastname and bithdate
    ///
    /// - Parameter Evaluation: `Evaluation` to be looked for
    /// - Returns: Evaluation if there is one in set, else nil
    func look(forEvaluation evaluation: Evaluation) -> Evaluation?{
        if let ret = EvaluationDAO.search(evaluation: evaluation){
            return ret
        }
        else{
            return nil
        }
    }
    
    /// `EvaluationSet` x `String` x `String` -> `Bool` -- look for `Evaluation` with these firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be search
    /// - Parameter lastname: `String` lastname to be search
    /// - Returns: True if there is one `Evaluation` with these firstname and lastname
    func contains(evaluationWith dateTime: NSDate) -> Bool{
        return EvaluationDAO.count(dateTime: dateTime) > 0
    }
    
    /// `EvaluationSet` x `String` x `String` -> `[Evaluation]` --
    /// look into set for Evaluations with this firstname and lastname
    ///
    /// - Parameter firstname: `String` firstname to be looked for
    /// - Parameter lastname: `String` lastname to be looked for
    /// - Parameter birthdate: `Date?` Date if it has one, else nil
    /// - Returns: `Evaluation` will these firstname, lastname and birthdate given in parameter, or nil if it is not in set
    func look(evaluationsWithDate dateTime: NSDate) -> [Evaluation]{
        if let ret = EvaluationDAO.search(dateTime: dateTime){
            return [ret]
        }
        else{
            return []
        }
    }
    
    /// `EvaluationSet` x `Evaluation` -> `Int?` --
    ///  returns index of the `Evaluation` in set with same firstname, lastname and birthdate
    ///
    /// - Parameter Evaluation: `Evaluation` with same firstname, lastname and birthdate as the one search
    /// - Returns: index of the `Evaluation` in set with same firstname, lastname and birthdate, or nil if it doesn't exist in set
    func indexOf(evaluation: Evaluation) -> Int?{
        guard let set = EvaluationDAO.fetchAll() else { return nil }
        var i : Int = 0
        while i < set.count{
            if set[i] == evaluation { return i }
            i += 1
        }
        return nil
    }
    
    subscript(index: Int) -> Evaluation{
        get{
            guard let set = EvaluationDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            return set[index]
        }
        set{
            guard var set = EvaluationDAO.fetchAll() else { fatalError("cannot fetch data") }
            guard (index>=0) && (index<set.count) else{ fatalError("index out of range") }
            EvaluationDAO.delete(evaluation: set[index])
            set[index]  = newValue
            EvaluationDAO.save()
        }
    }
    
    /// `EvaluationSet` -> `ItEvaluationSet` -- make an iterator on the set
    ///
    /// - Returns: a new iterator on the set initialized on the first element
    func makeIterator() -> ItEvaluationSet{
        return ItEvaluationSet(self)
    }
    
}

// MARK: -

/// Iterator on EvaluationSet
struct ItEvaluationSet : IteratorProtocol{
    private var current: Int = 0
    private let set: [Evaluation]
    
    fileprivate init(_ s: EvaluationSet){
        if let set = EvaluationDAO.fetchAll(){
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
    mutating func reset() -> ItEvaluationSet{
        self.current = 0
        return self
    }
    
    @discardableResult
    mutating func next() -> Evaluation? {
        guard self.current < self.set.count else{
            return nil
        }
        let nextEvaluation = self.set[self.current]
        self.current += 1
        return nextEvaluation
    }
    
    /// true if iterator as finished
    var end : Bool{
        return self.current < self.set.count
    }
}





