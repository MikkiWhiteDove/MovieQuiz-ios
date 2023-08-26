//
//  MyMovieQuizUITests.swift
//  MyMovieQuizUITests
//
//  Created by Mishana on 10.08.2023.
//

import XCTest

class MovieQuizUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launch()
        
        continueAfterFailure = false
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        
        app.terminate()
        app = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testYesButton() throws {
        sleep(3)
        let firstPoster = app.images["Poster"]
        let firstPosterData = firstPoster.screenshot().pngRepresentation
        
        app.buttons["Yes"].tap()
        sleep(3)
        let statisticText = app.staticTexts["Index"]
        let secondPoster = app.images["Poster"]
        let secondPosterData = secondPoster.screenshot().pngRepresentation
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(statisticText.label, "2/10")
    }
    
    func testNoButton() throws {
        sleep(3)
        let firtstPoster = app.images["Poster"]
        let firstPosterData = firtstPoster.screenshot().pngRepresentation
        
        app.buttons["No"].tap()
        sleep(3)
        
        let statisticText = app.staticTexts["Index"].label
        let secondPosterData = app.images["Poster"].screenshot().pngRepresentation
        
        XCTAssertNotEqual(firstPosterData, secondPosterData)
        XCTAssertEqual(statisticText, "2/10")
    }
    
    func testFinishAlert() throws {
        
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Game results"]
        
        XCTAssertTrue(alert.exists)
        XCTAssertTrue(alert.label == "Этот раунд окончен!")
        XCTAssertTrue(alert.buttons.firstMatch.label == "Сыграть ещё раз")
    }
    
    func testExist() throws {
        
        sleep(2)
        for _ in 1...10 {
            app.buttons["No"].tap()
            sleep(2)
        }
        
        let alert = app.alerts["Game results"]
        alert.buttons.firstMatch.tap()
        sleep(2)
        
        let statisticText = app.staticTexts["Index"]
        
        XCTAssertFalse(alert.exists)
        XCTAssertEqual(statisticText.label, "1/10")
    }
}
