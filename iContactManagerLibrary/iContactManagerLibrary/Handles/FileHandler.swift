//
//  FileHandler.swift
//  iContactManagerVCF
//
//  Created by rodor on 08-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

import SwiftUI

class FileHandler {
    // Status: prints path|url directory, should list files
    class func listContentOfBundleDirectory(){
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        do {
            let items = try fm.contentsOfDirectory(atPath: path)
            for item in items {
                print("Found \(item)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Status: prints path|url directory, should list files
    class func listContentOfDocumentsDirectory(){
        let fm = FileManager.default
        do {
            let items = fm.urls(for: .documentDirectory, in: .userDomainMask)
            for item in items {
                print("Found \(item)")
            }
        }
    }
    
    // Status:
    class func readFileStoredInDocumentsDirectory(filename: String){
        let url = FileHandler.getDocumentsDirectory().appendingPathComponent(filename)
        do {
            let input = try String(contentsOf: url)
            print("Reading \(url)")
            print("Content \(input)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // Status:
    class func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    // Status:
    class func printDocumentDirectoryFiles() {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        paths.forEach { path in
            print("absoluteURL: \(path.absoluteURL)")
            print("absoluteString: \(path.absoluteString)")
        }
        // for word in paths { print(path) }
    }
}
