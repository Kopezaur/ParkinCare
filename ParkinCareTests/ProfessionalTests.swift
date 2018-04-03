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
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        // Initiate titles
        title1 = Title(name: "Neurologue")
        title2 = Title(name: "Psychologue")
        
        // Initiate professionals
        prof1 = Professional(lastname: "Copetchi", firstname: "Stefan", title: title1, organization: "Polytech Bucharest", email: "stefan-dragos.copetchi@etu.umontpellier.fr", numTel: "13")
        prof2 = Professional(lastname: "Turgut", firstname: "Fabien", title: title2, organization: "Polytech Montpellier", email: "fabien.turgut@etu.umontpellier.fr", numTel: "007")
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        // Tear down the titles
        title1 = nil
        title2 = nil
        
        // Tear down the professionals
        prof1 = nil
        prof2 = nil
        
    }
    
    func testExistenceInCoreData() {
        // Tests for first professional
        XCTAssertNoThrow(Professional.count(professional: prof1))
        XCTAssertNoThrow(Professional.search(professional: prof1))
        
        // Tests for the second professional
        XCTAssertNoThrow(Professional.count(professional: prof2), "Test(Count prof2)")
        XCTAssertNoThrow(Professional.search(professional: prof2), "Test")
        
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
