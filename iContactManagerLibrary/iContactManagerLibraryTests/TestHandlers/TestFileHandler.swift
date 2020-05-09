//
//  TestFileHandler.swift
//  iContactManagerVCFTests
//
//  Created by rodor on 08-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

import XCTest
import Contacts

@testable import iContactManagerLibrary

class TestFileHandler: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    func testListContentOfBundleDirectory(){
        FileHandler.listContentOfBundleDirectory()
    }
    
    func testListContentOfDocumentsDirectory(){
        FileHandler.listContentOfDocumentsDirectory()
    }
    
    func testReadFileStoredInDocumentsDirectory(){
        let file = "PIM00001.vcf"
        FileHandler.readFileStoredInDocumentsDirectory(filename: file)
    }
    
    func testGetDocumentsDirectory(){
        let documentsDir = FileHandler.getDocumentsDirectory()
        print(documentsDir) // file:///var/mobile/Containers/Data/Application/7753A40D-90D4-4A14-A086-331979C886C5/Documents/
    }
    
    func testPrintDocumentDirectoryFiles(){
        FileHandler.printDocumentDirectoryFiles()
    }
}
