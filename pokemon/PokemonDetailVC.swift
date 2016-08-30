//
//  PokemonDetailVC.swift
//  pokemon
//
//  Created by ganga sanka on 8/27/16.
//  Copyright © 2016 haasith. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController
{
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var pokeDescription: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var pokedexIdLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var evolutionLabel: UILabel!
    @IBOutlet weak var currentEvo: UIImageView!
    @IBOutlet weak var nextEvo: UIImageView!
    
    @IBAction func backButtonPressed(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    var pokemon:Pokemon!
    
    
    override func viewDidLoad() {
        nameLabel.text = pokemon.name
        pokeImage.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvo.image = UIImage(named: "\(pokemon.pokedexId)")
        
        pokemon.downloadPokemonDetails { () -> () in
            
            self.updateUI()
            
            
        }
        
    }
    
    func updateUI()
    {
        pokeDescription.text = pokemon.description
        typeLabel.text = pokemon.type
        heightLabel.text = pokemon.height
        weightLabel.text = pokemon.weight
        attackLabel.text = pokemon.attack
        defenseLabel.text = pokemon.defense
        pokedexIdLabel.text = "\(pokemon.pokedexId)"
        
        if pokemon.nextEvolutionId == ""
        {
            evolutionLabel.text = "NO EVOLUTIONS"
            nextEvo.hidden = true
        }
        else
        {
            nextEvo.hidden = false
            nextEvo.image = UIImage(named: pokemon.nextEvolutionId)
            var nextEvoStr = "Next Evolution: \(pokemon.nextEvolutionText)"
            
            if pokemon.nextEvolutionLevel != ""
            {
                nextEvoStr += " - LVL \(pokemon.nextEvolutionLevel)"
            }
            
            evolutionLabel.text = nextEvoStr
            
        }
        
    }

}
