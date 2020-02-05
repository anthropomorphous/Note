//
//  NoteTests.swift
//  NoteTests
//
//  Created by ios_school on 2/3/20.
//  Copyright © 2020 ios_school. All rights reserved.
//

import XCTest
@testable import Note

let date = Date()
let timeInterval = date.timeIntervalSince1970

class NoteTests: XCTestCase {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDefaultNote() {
        
        let note = Note(uid: "uid",
                        title: "title",
                        content: "content",
                        color: UIColor.red,
                        selfDestructDate: Date(),
                        importance: .unimportant)
        
        let jsonNote = note.json
        
        guard let noteParsed = Note.parse(json: jsonNote) else {
            XCTFail("Note initializing failed")
            return
        }
        
        XCTAssertEqual(noteParsed.uid, note.uid)
        XCTAssertEqual(noteParsed.title, note.title)
        XCTAssertEqual(noteParsed.content, note.content)
        XCTAssertEqual(noteParsed.color, note.color)
        XCTAssertEqual(noteParsed.selfDestructDate?.timeIntervalSince1970, note.selfDestructDate?.timeIntervalSince1970)
        XCTAssertEqual(noteParsed.importance, note.importance)
    }
    
    func testDefaultNoteWithoutColor() {
        
        let note = Note(uid: "uid",
                        title: "title",
                        content: "content",
                        selfDestructDate: date,
                        importance: .unimportant)
        
        let jsonNote = note.json
        
        guard let noteParsed = Note.parse(json: jsonNote) else {
            XCTFail("Note initializing failed")
            return
        }
                
        XCTAssertEqual(noteParsed.uid, note.uid)
        XCTAssertEqual(noteParsed.title, note.title)
        XCTAssertEqual(noteParsed.content, note.content)
        XCTAssertEqual(UIColor.white, note.color)
        XCTAssertEqual(noteParsed.selfDestructDate?.timeIntervalSince1970, note.selfDestructDate?.timeIntervalSince1970)
        XCTAssertEqual(noteParsed.importance, note.importance)
    }
    
    func testDefaultNoteWithoutDate() {
        
        let note = Note(uid: "uid",
                        title: "title",
                        content: "content",
                        color: UIColor.red,
                        selfDestructDate: nil,
                        importance: .unimportant)
        
        let jsonNote = note.json
        
        guard let noteParsed = Note.parse(json: jsonNote) else {
            XCTFail("Note initializing failed")
            return
        }
        
        XCTAssertEqual(noteParsed.uid, note.uid)
        XCTAssertEqual(noteParsed.title, note.title)
        XCTAssertEqual(noteParsed.content, note.content)
        XCTAssertEqual(noteParsed.color, note.color)
        XCTAssertEqual(noteParsed.selfDestructDate, note.selfDestructDate)
        XCTAssertEqual(noteParsed.importance, note.importance)
    }

    func testNoteWithoutCompulsoryTitleField() {
        
        let note = Note(uid: "uid",
                        title: "title",
                        content: "content",
                        color: UIColor.red,
                        selfDestructDate: nil,
                        importance: .unimportant)
        
        var jsonNote = note.json
            jsonNote[uidKey] = nil
        
        let noteParsed = Note.parse(json: jsonNote)
        
        XCTAssertNil(noteParsed, "Note cannot be parsed with this conditions")
    }
    
    func testNoteWithIncorrectField() {
        
        let note = Note(uid: "uid",
                        title: "title",
                        content: "content",
                        color: UIColor.red,
                        selfDestructDate: nil,
                        importance: .unimportant)
        
        var jsonNote = note.json
            jsonNote[uidKey] = nil
        
        let noteParsed = Note.parse(json: jsonNote)
        
        XCTAssertNil(noteParsed, "Note cannot be parsed with this conditions")
    }
    
    func testNoteWithIncorrectFieldType() {

        var json = [String: Any]()
        
        json[uidKey] = 123454321;
        json[titleKey] = "title";
        json[contentKey] = "content";
        json[colorKey] = "#FF0000FF";
        json[selfDestructDateKey] = timeInterval;
        json[importanceKey] = "unimportant"
        
        let noteParsed = Note.parse(json: json)
        
        XCTAssertNil(noteParsed, "Note cannot be parsed with this conditions")
    }
    
    // optional test cases
    
    func testNoteWithoutCompulsoryContentField() {
        var json = [String: Any]()

        json[uidKey] = "uid";
        json[contentKey] = "content";
        json[colorKey] = "#FF0000FF";
        json[selfDestructDateKey] = timeInterval;
        json[importanceKey] = "unimportant"
            
        let noteParsed = Note.parse(json: json)
            
        XCTAssertNil(noteParsed, "Note cannot be parsed with this conditions")
        }
    
    func testNoteWithoutCompulsoryUidField() {
        var json = [String: Any]()

        json[titleKey] = "title"
        json[contentKey] = "content";
        json[colorKey] = "#FF0000FF";
        json[selfDestructDateKey] = timeInterval;
        json[importanceKey] = "unimportant"
            
        let noteParsed = Note.parse(json: json)
            
        XCTAssertNil(noteParsed, "Note cannot be parsed with this conditions")
        }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
