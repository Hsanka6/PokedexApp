//
//  Pokemon.swift
//  pokemon
//
//  Created by ganga sanka on 8/21/16.
//  Copyright © 2016 haasith. All rights reserved.
//

import UIKit

class Pokemon{
    private var _name: String!
    private var _pokedexId:Int!
    
    
    var name:String
    {
        return _name
    }
    
    var pokedexId:Int
    {
        return _pokedexId
    }
    
    
    init(name:String, pokedexId:Int)
    {
        self._name = name
        self._pokedexId = pokedexId
    }
    
}
