//
//  TestFileMockr.swift
//  iContactManagerVCFTests
//
//  Created by rodor on 08-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

import XCTest
import Foundation

@testable import iContactManagerLibrary

class TestFileMockr: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    func testCreateFileInDocumentDirectory(){
        FileMockr.createFileInDocumentDirectory()
    }
    
}
