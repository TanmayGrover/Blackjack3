//
//  Deck.swift
//  BlackJackUltimate
//
//  Created by Tanmay Grover on 3/4/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

//
//  Dealer.swift
//  BlackJack
//
//  Created by Tanmay Grover on 2/17/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import Foundation


class Deck{
    var deck = [Int]()
    
    var deckCount = 3
    //returns dealer card
    func dealCard ( c : Int) {
        for i in 1...c{
            for index in 0...3{
                for item in 1...13{
                    //Putting deck with card values .
                    if item > 10 {
                        deck.append(10)
                    }else{
                        deck.append(item)
                        
                    }
                }
            }
        }
    
        Singelton.sharedInstance.sdeck=deck
        println(deck[9])
    }
    //Help from google
    func shuffle() {
        var temp: Int
        for i in 0...(deck.count-1) {
            let j = Int(arc4random_uniform(UnicodeScalarValue(deck.count)))
            temp = deck[i]
            println(i,j)
            deck[i]=deck[j]
            deck[j]=temp
            
        }
        Singelton.sharedInstance.sdeck=deck
    }
    
    
    
}