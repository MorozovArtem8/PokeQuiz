//
//  PokeData.swift
//  PokeQuiz
//
//  Created by Artem Morozov on 06.11.2023.
//

import Foundation
struct Poke {
    let name: String
    
}
let pokeArray = ["Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard", "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree", "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Rattata", "Raticate", "Pidgeot"]

func createArrayStruct(array: [String]) -> [Poke]{
    var pokeArrayStruct: [Poke] = []
    for str in array{
        pokeArrayStruct.append(Poke.init(name: str))
    }
    return pokeArrayStruct
}

