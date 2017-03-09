//
//  BDDFunctions.swift
//  Observe
//
//  Created by Sam Meech-Ward on 2017-03-01.
//
//

import Foundation

/**
 Responsible for creating the new test type and adding it to the tree structure.
 
 - parameter message: The message passed into the function.
 - parameter message: The file the function is called from.
 - parameter message: The line number in that file that the function is called from.
 - parameter message: The logic that will get exectued.
 */
private func addTestBlock(_ message: String, blockType: BlockType, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    
    let test = ObserveTest()
    test.closure = handler
    test.message = message

    test.blockType = blockType

    test.file = file
    test.line = line
    test.method = method
    
    if var currentTest = Observe.currentTest {
        currentTest.addChild(test: test)
    } else {
        Observe.currentTest = test
    }
    
    Observe.runTests()
}

public func describe(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .describe, file: file, line: line, method: method, handler: handler)
}

public func context(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .context, file: file, line: line, method: method, handler: handler)
}

public func it(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .it, file: file, line: line, method: method, handler: handler)
}

public func given(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .given, file: file, line: line, method: method, handler: handler)
}

public func when(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .when, file: file, line: line, method: method, handler: handler)
}

public func then(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .then, file: file, line: line, method: method, handler: handler)
}

public func and(_ message: String, file: StaticString = #file, line: UInt = #line, method: String = #function, handler: @escaping ((Void) -> (Void))) {
    addTestBlock(message, blockType: .and, file: file, line: line, method: method, handler: handler)
}


/**
 Called before each of the blocks within the same scope.
 */
public func beforeEach(file: StaticString = #file, line: UInt = #line, handler: @escaping ((Void) -> (Void))) {
    guard var currentTest = Observe.currentTest else {
        print("🖕🏼Error: beforeEach must go inside a function")
        return
    }
    
    currentTest.beforeEachChild = handler
}