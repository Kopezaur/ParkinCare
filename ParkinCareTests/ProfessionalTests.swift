//
//  ProfessionalTests.swift
//  ParkinCare
//
//  Created by Stefan-Dragos COPETCHI on 03/04/2018.
//  Copyright © 2018 Kopezaur. All rights reserved.
//

import XCTest
@testable import ParkinCare

class ProfessionalTests: XCTestCase {
    
    var prof1 : Professional!
    
    var prof2 : Professional!
    
    var title1 : Title!
    
    var title2 : Title!
    
    var profSet : ProfessionalSet!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // Initiate titles
        title1 = Title(name: "TitleTest1")
        title2 = Title(name: "TitleTest2")
        
        // Initiate professionals
        prof1 = Professional(lastname: "Test", firstname: "Stefan", title: title1, organization: "Polytech Bucharest", email: "stefan-test@etu.umontpellier.fr", numTel: "13")
        prof2 = Professional(lastname: "Test", firstname: "Fabien", title: title2, organization: "Polytech Montpellier", email: "fabien-test@etu.umontpellier.fr", numTel: "007")
        
        // Initiate the professional set
        profSet = ProfessionalSet()
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        // Tear down the titles
        TitleDAO.delete(title: title1)
        TitleDAO.delete(title: title2)
        self.title1 = nil
        self.title2 = nil
        
        // Tear down the professionals
        ProfessionalDAO.delete(professional: prof1)
        ProfessionalDAO.delete(professional: prof2)
        self.prof1 = nil
        self.prof2 = nil
        
        // Tear down the professional set
        self.profSet = nil
        
    }
    
    func testProfessionalExtension() {
        // Tests for the first professional
        XCTAssertNoThrow(Professional.count(professional: prof1))
        XCTAssertNoThrow(Professional.search(professional: prof1))
        
        // Tests for the second professional
        XCTAssertNoThrow(Professional.count(professional: prof2), "Test(Count for prof2)")
        XCTAssertNoThrow(Professional.search(professional: prof2), "Test(Search for prof2)")
    }
    
    func testDAO() {
        // Test the DAO functions
        XCTAssertNoThrow(ProfessionalDAO.count)
        
        XCTAssertNoThrow(ProfessionalDAO.fetchAll())
        
        XCTAssertNoThrow(ProfessionalDAO.count(professional: prof1))
        
        XCTAssertNoThrow(ProfessionalDAO.add(professional: prof1))
        
        XCTAssertNoThrow(ProfessionalDAO.delete(professional: prof1))
    }
    
    func testProfessionalSet() {
        // Test the professional set functions
        XCTAssertNoThrow(profSet.makeIterator())

        XCTAssertNoThrow(profSet.add(professional: prof1))

        XCTAssertNoThrow(profSet.add(professional: prof2))

        XCTAssertNoThrow(profSet.count)

        XCTAssertTrue(profSet.contains(prof2))

        XCTAssertNoThrow(profSet.indexOf(professional: prof2))
        
        XCTAssertNoThrow(profSet.remove(professional: prof2))
        
        XCTAssertNoThrow(profSet.remove(professional: prof1))
        
        XCTAssertFalse(profSet.contains(prof2))
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            let _ = ProfessionalDAO.fetchAll()
        }
    }
    
}
