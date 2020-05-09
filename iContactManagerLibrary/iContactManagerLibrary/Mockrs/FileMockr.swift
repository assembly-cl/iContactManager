//
//  FileMockr.swift
//  iContactManagerVCF
//
//  Created by rodor on 08-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

import Foundation

class FileMockr {
    
    class func createFileInDocumentDirectory(){
        print("привет..")
        let filename = "filemockr.txt"
        let str = "Test Message From FileMockr"
        let url = FileHandler.getDocumentsDirectory().appendingPathComponent(filename)
        
        do {
            try str.write(to: url, atomically: true, encoding: .utf8)
            let input = try String(contentsOf: url)
            print("Reading from \(url)")
            print("Content \(input)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
