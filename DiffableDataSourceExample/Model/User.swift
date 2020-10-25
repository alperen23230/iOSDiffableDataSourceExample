//
//  User.swift
//  DiffableDataSourceExample
//
//  Created by Alperen Ünal on 25.10.2020.
//

import Foundation


struct User: Hashable {
    let id = UUID()
    let name: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
