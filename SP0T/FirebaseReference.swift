//
//  FirebaseReference.swift
//  SP0T
//
//  Created by kbarone on 6/28/18.
//  Copyright © 2018 Spot LLC. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

enum DatabaseReferenceEnums {
    case root
    case users(uid: String)
    
    //Mark: - public
    
    func reference() -> DatabaseReference {
        switch self {
        case .root:
            return rootReference
        default:
            return rootReference.child(path)
        }
        //returns reference to our database
    }
    private var rootReference: DatabaseReference {
        return Database.database().reference()
    }
    private var path: String{
        switch self {
        case .root:
            return ""
        case .users(let uid):
            return "users/\(uid)"
        }
    }
}
