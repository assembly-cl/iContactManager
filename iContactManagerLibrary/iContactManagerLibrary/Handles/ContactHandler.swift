//
//  ContactHandler.swift
//  iContactManagerVCF
//
//  Created by rodor on 04-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

/**
 To-do
 - [✓] Parse vCard, read function.
 - [ ] Functions to process Contacts object: read ✓, create ✓, update, delete.
 - [ ] Functions to merge attribute by contacts' name: phone number, e-mail
 - [ ] Functions to update attributes by contacts' name: phone number, e-mail
 - [✓] Unit Tests: iContactManagerVCFTests
 
 References
 https://developer.apple.com/documentation/contacts
 https://developer.apple.com/documentation/contacts/cncontactvcardserialization
 */

import Foundation
import Contacts

class ContactHandler {
    // Contacts: get by name
    // Status: working, needs filtering improvements
    class func getContactsByName(contactName: String) -> [CNContact] {
        var contacts : [CNContact] = []
        let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        // let keysToFetch = [CNContactEmailAddressesKey as CNKeyDescriptor, CNContactFormatter.descriptorForRequiredKeys(for: .fullName)]
        // let keysToFetch = [CNContactGivenNameKey, CNContactFamilyNameKey] as [CNKeyDescriptor]
        let store = CNContactStore()
        do {
            let predicate = CNContact.predicateForContacts(matchingName: contactName)
            contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            // print("Fetched contacts: \(contacts)")
            return contacts
        } catch {
            print("Failed to fetch contact, error: \(error)")
            // TODO: handle the error
            return contacts
        }
    }
    
    // Contacts: read all
    // Status: ready
    class func getContacts() -> [CNContact] {
        var contacts : [CNContact] = []
        let contatcStore = CNContactStore()
        let fetchRequest = CNContactFetchRequest.init(keysToFetch: [CNContactVCardSerialization.descriptorForRequiredKeys()])
        try! contatcStore.enumerateContacts(with: fetchRequest) { (contact, end) in
            contacts.append(contact)
        }
        return contacts
    }
    
    // Contacts: create
    // Status: working with mininum requeried parameters (name, phone number)
    class func createContact(contactGivenName: String, contactFamilyName: String, contactPhoneNumber: String) -> Bool {
        var result = true
        
        let contact = CNMutableContact()
        contact.givenName = contactGivenName
        contact.familyName = contactFamilyName
        
        let newPhoneNumber =
            CNLabeledValue(
                label: CNLabelPhoneNumberiPhone,
                value: CNPhoneNumber(stringValue: contactPhoneNumber))
        
        contact.phoneNumbers.append(newPhoneNumber)
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        
        do {
            try store.execute(saveRequest)
        } catch {
            print("Saving contact failed, error: \(error)")
            // TODO: handle the error ..
            result = false
        }
        return result
    }
    
    // Contacts: update
    // Status: incomplete, find by dynamic or fixed filter
    class func updateContact(contact: CNContact, contactPhoneNumber: String) -> Bool {
        var result = true
        
        // TODO: find contact by phone number, remove CNContact from parameters
        // TODO: add new number to existing contact
        // TODO: add a parameter to identify the type {CNLabelPhoneNumberMain, CNLabelPhoneNumberMobile, ...}
        
        guard let mutableContact = contact.mutableCopy() as? CNMutableContact else { return false }
        
        let newPhoneNumber =
            CNLabeledValue(
                label: CNLabelPhoneNumberiPhone,
                value: CNPhoneNumber(stringValue: contactPhoneNumber))
        
        mutableContact.phoneNumbers.append(newPhoneNumber)
        
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.update(mutableContact)
        
        do {
            try store.execute(saveRequest)
        } catch {
            print("Saving contact failed, error: \(error)")
            // TODO: handle the error ..
            result = false
        }
        return result
    }
    
    // Contact: print information
    // Status: ready
    class func printContact(contact: CNContact) {
        // TODO: print all relavant atributes, based on createContact func
        let fullName = CNContactFormatter.string(from: contact, style: .fullName)
        print("\(String(describing: fullName))")
    }
    
}
