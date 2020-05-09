//
//  TestContactHandler.swift
//  iContactManagerVCFTests
//
//  Created by rodor on 08-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

import XCTest
import Contacts

@testable import iContactManagerLibrary

class TestContactHandler: XCTestCase {
    
    override func setUp() {}
    
    override func tearDown() {}
    
    // Disabled
    func testCreateContact(){
        print(ContactHandler.createContact(contactGivenName: "Rodrigo", contactFamilyName: "Erazo Hermosilla", contactPhoneNumber: "+56990842361"))
    }
    
    func testGetContacts(){
        // self.measure {
        let contacts = ContactHandler.getContacts()
        print("contacts: \(contacts.count) ")
        var n = 0
        for contact in contacts {
            n += 1
            let fullName = CNContactFormatter.string(from: contact, style: .fullName)
            print("contact \(n): \(String(describing: fullName!))")
        }
    }
    
    func testGetContactsByName() {
        let name = "Rodrigo"
        let contactsByName = ContactHandler.getContactsByName(contactName: name)
        for contact in contactsByName {
            print("FindByName \(name) > \(contact.givenName) \(contact.familyName): \(contact.phoneNumbers.first?.value.stringValue ?? "n/a")")
        }
    }
    
    func testTrimmingCharacters_WhitespacesAndNewlines(){
        let str = " Call Center ".trimmingCharacters(in: .whitespacesAndNewlines)
        print("|\(str)|")
    }
    
    // TDD
    func testImportContactsFromFileStoredInDocumentDirectory(){
        let filename = "PIM00003.vcf"
        let url = FileHandler.getDocumentsDirectory().appendingPathComponent(filename)
        do {
            let input = try String(contentsOf: url)
            let cafe: Data? = input.data(using: .utf8)
            
            let vcard = try CNContactVCardSerialization.contacts(with: cafe!)
            let filterByKeywords = ["Spam", "Servicio", "Call Center", "Atencion al Cliente", "Municipalidad", "Banco", "Delivery"]
            var filterByFullName = [""]
            var filterByPhoneNumber = [""]
            let contacts = ContactHandler.getContacts()
            let contactsBeforeProcess = contacts.count
            for contact in contacts {
                let name = contact.givenName.trimmingCharacters(in: .whitespacesAndNewlines)
                let family = contact.familyName.trimmingCharacters(in: .whitespacesAndNewlines)
                filterByFullName.append(name + " " + family)
                for phone in contact.phoneNumbers {
                    let phoneNumber = phone.value.stringValue
                    let phoneNumberNoWhiteSpaces = phone.value.stringValue.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                    filterByPhoneNumber.append(phoneNumber)
                    if(phoneNumber != phoneNumberNoWhiteSpaces) {
                        filterByPhoneNumber.append(phoneNumberNoWhiteSpaces)
                    }
                }
            }
            // print(filterByFullName)
            // print(filterByPhoneNumber)
            
            for contact in vcard {
                let name = contact.givenName.trimmingCharacters(in: .whitespacesAndNewlines)
                let family = contact.familyName.trimmingCharacters(in: .whitespacesAndNewlines)
                let phone = contact.phoneNumbers.first?.value.stringValue ?? "na"
                
                if filterByKeywords.contains(name)
                    || filterByKeywords.contains(family)
                    || filterByFullName.contains(name + " " + family)
                    || filterByPhoneNumber.contains(phone){
                    
                    // print("Filtered > \(name) \(family): \(phone)")
                } else {
                    if contact.phoneNumbers.first?.value.stringValue != nil {
                        // Debug:
                        print("New Contact > \(name) \(family): \(phone)")
                        // print("Contact > \(name): \(phone)")
                        // print("Contact > \(family): \(phone)")
                        
                        // Main task:
                        // let result = ContactHandler.createContact(contactGivenName: name, contactFamilyName: family, contactPhoneNumber: phone) ? "ok" : "error"
                        // print("New Contact > \(name) \(family): \(phone) > \(result)")
                    }
                }
            }
            
            let contactsAfterProcess = ContactHandler.getContacts().count
            print("Contacts before process: \(contactsBeforeProcess)")
            print("Contacts after process: \(contactsAfterProcess)")
        } catch {
            print(error.localizedDescription)
        }
    }
}
