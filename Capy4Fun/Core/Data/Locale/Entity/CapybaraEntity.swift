//
//  CapybaraEntity.swift
//  Capy4Fun
//
//  Created by Mputh on 09/12/25.
//

import Foundation
import RealmSwift

class CapybaraEntity: Object {
    
    @objc dynamic var id: String = ""
    @objc dynamic var title: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var desc: String = ""
    
    override nonisolated static func primaryKey() -> String? {
        return "id"
    }
    
}
