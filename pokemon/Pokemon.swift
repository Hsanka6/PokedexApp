//
//  Pokemon.swift
//  pokemon
//
//  Created by ganga sanka on 8/21/16.
//  Copyright © 2016 haasith. All rights reserved.
//

import UIKit
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokedexId:Int!
    private var _description:String!
    private var _attack:String!
    private var _defense:String!
    private var _type:String!
    private var _height:String!
    private var _weight:String!
    private var _nextEvolutionText:String!
    private var _nextEvolutionId:String!
    private var _nextEvolutionLevel:String!
    private var _pokemonUrl:String!
    
    
    
    var description:String
    {
        if _description == nil
        {
            _description = ""
        }
        return _description
    }
    
    var attack:String
    {
        if _attack == nil
        {
            _attack = ""
        }
        return _attack
    }
    
    var defense:String
    {
        if _defense == nil
        {
            _defense = ""
        }
        return _defense
    }
    
    var type:String
    {
        if _type == nil
        {
            _type = ""
        }
        return _type
    }
    
    var height:String
    {
        if _height == nil
        {
            _height = ""
        }
        return _height
    }
    
    var weight:String
    {
        if _weight == nil
        {
            _weight = ""
        }
        return _weight
    }
    
    var nextEvolutionText:String
    {
        if _nextEvolutionText == nil
        {
            _nextEvolutionText = ""
        }
        return _nextEvolutionText
    }
    
    var nextEvolutionLevel:String
    {
        if _nextEvolutionLevel == nil
        {
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var nextEvolutionId:String
    {
        if _nextEvolutionId == nil
        {
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var pokedexId:Int
    {
        return _pokedexId
    }
    var name:String
    {
        return _name
    }
    
    
    init(name:String, pokedexId:Int)
    {
        self._name = name
        self._pokedexId = pokedexId
        
        _pokemonUrl = "\(BASE_URL)\(POKE_URL)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed:DownloadComplete)
    {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET,url).responseJSON{ response in
            let result = response.result
            
            print(result.value.debugDescription)
            
            if let dict = result.value as? Dictionary<String,AnyObject>
            {
                if let weight = dict["weight"] as? String
                {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String
                {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int
                {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int
                {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0
                {
                    if let type = types[0]["name"]
                    {
                        self._type = type.capitalizedString
                    }
                    
                    if types.count > 1
                    {
                    
                    if let type = types[1]["name"]
                    {
                        self._type! += "/\(type.capitalizedString)"
                    }
                    }
                    
                }
                else
                {
                    self._type = ""
                    
                }
                
                if let description = dict["descriptions"] as? [Dictionary<String,String>] where description.count > 0
                {
                    if let url = description[0]["resource_uri"]
                    {
                        let url = NSURL(string: "\(BASE_URL)\(url)")!
                        Alamofire.request(.GET,url).responseJSON{ response in
                            let result = response.result
                            
                            if let description = result.value as? Dictionary<String,AnyObject>
                            {
                                if let description = description["description"] as? String
                                {
                                    self._description = description
                                    print(self._description)
                                    
                                }
                            }
                            completed()
                            
                        }
                    }
                }
                else
                {
                    self._description = ""
                }
                
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evolutions.count > 0
                {
                    if let to = evolutions[0]["to"] as? String
                    {
                        if to.rangeOfString("mega") == nil
                        {
                            if let uri = evolutions[0]["resource_uri"] as? String
                            {
                               let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                
                                let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                
                                self._nextEvolutionId = num
                                self._nextEvolutionText = to
                                if let level = evolutions[0]["level"] as? Int
                                {
                                    self._nextEvolutionLevel = "\(level)"
                                }
                                
                            }
                            
                        }
                    }
                }
                
                
                
                
            }
            
        }
        
        
    }
    
}
