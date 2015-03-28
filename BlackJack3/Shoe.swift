//
//  Shoe.swift
//  BlackJackUltimate
//
//  Created by Tanmay Grover on 3/23/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import Foundation

class Shoe   {
    
    var cards = [Int]()
    
    //var noOfDecks : Int = 0
    
    var d = Deck()
    
    init() {
        
        
        cards = d.deck
    }
    
    
}