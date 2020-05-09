//
//  ContactMockr.swift
//  iContactManagerVCF
//
//  Created by rodor on 07-05-20.
//  Copyright © 2020 Assembly Chile. All rights reserved.
//

import Contacts

// Contacts: create
func createContactMock() -> Bool {
    var result = true
    let contact = CNMutableContact()
    
    // let image = UIImage(systemName: "person.crop.circle")
    // contact.imageData = image?.jpegData(compressionQuality: 1.0)
    
    contact.givenName = "Rodrigo"
    contact.familyName = "Erazo Hermosilla"
    
    let homeEmail = CNLabeledValue(label: CNLabelHome, value: "rodor@assembly.cl" as NSString)
    let workEmail = CNLabeledValue(label: CNLabelWork, value: "rerazo@assembly.cl" as NSString)
    contact.emailAddresses = [homeEmail, workEmail]
    
    contact.phoneNumbers = [CNLabeledValue(
        label: CNLabelPhoneNumberiPhone,
        value: CNPhoneNumber(stringValue: "+56997777777"))]
    
    let homeAddress = CNMutablePostalAddress()
    homeAddress.street = "Valdivia 7777"
    homeAddress.city = "Santiago"
    // homeAddress.state = "Providencia"
    // homeAddress.postalCode = "777"
    contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]
    
    var birthday = DateComponents()
    birthday.day = 11
    birthday.month = 4
    birthday.year = 1892
    contact.birthday = birthday
    
    // Saving
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

