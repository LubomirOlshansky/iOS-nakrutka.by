//
//  ApiKeySingletone.swift
//  nakrutka.by
//
//  Created by Lubomir Olshansky on 06/02/2018.
//  Copyright © 2018 Lubomir Olshansky. All rights reserved.
//

class ApiKeySingletone {
    
    static let shared  = ApiKeySingletone()
    
    private init(){}
    
    var apiKey = ""
}
