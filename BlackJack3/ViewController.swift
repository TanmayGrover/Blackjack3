//
//  ViewController.swift
//  BlackJack3
//
//  Created by Tanmay Grover on 3/24/15.
//  Copyright (c) 2015 Tanmay Grover. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //Declarations
    @IBOutlet weak var playerCards: UIView!
    
    //@IBOutlet weak var playercard1: UIImageView!
    
    @IBOutlet weak var aiCards: UIView!
    
    
    @IBOutlet weak var dealerCardsView: UIView!
    
    
    @IBOutlet weak var gameStatus: UILabel!
    
    
    //Initialisation
    
    var deckObject = Deck()
     var dealerObject = Dealer()
    var noOfPlayers :Int = 1
    var playerArray :[Player] = []
    var dealerFlip : Bool = false
    
    var value : Int = 0
    
    var round : Int = 1
    
    var i1 : Int = 0
    var j1 : Int = 0
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.playercard1.image = UIImage(named: "card5")
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* func createCardSubView(x : CGFloat , y : CGFloat , width : CGFloat , height : CGFloat , imageName : String) -> UIView {
    let testFrame : CGRect = CGRectMake(x,y,width,height)
    var testView : UIView = UIView(frame: testFrame)
    var image = UIImage(named: imageName)
    if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Phone {
    image = imageWithImage(image!, scaledToSize: CGSize(width: 27, height: 40))
    }
    let imageView = UIImageView(image: image)
    testView.addSubview(imageView)
    return testView
    }*/
    
    
    
    
    @IBAction func Deal(sender: AnyObject) {
        
        deckObject.dealCard(2)
        deckObject.shuffle()
        //for var index = 0; index < noOfPlayers; ++index {
            
            
            var p = Player(name: "P\(0)", money:100 )
            playerArray.append(p)
        
        var p2 = Player(name: "P\(0)", money:100 )
            playerArray.append(p2)
        
        println("inside method \(0)")
            
            playerArray[0].hand.cards.removeAll()
            playerArray[0].setUpHand()
        displayCards(playerArray[0].hand.cards, playerCardView : playerCards, yCord : 56 , dealerCard : dealerFlip)
            playerArray[0].hand.status = statusOfHand.turn
        
            playerArray[1].hand.cards.removeAll()
          playerArray[1].setUpHand()
        displayCards(playerArray[1].hand.cards , playerCardView: aiCards, yCord: 46 , dealerCard : dealerFlip)
        
        dealerObject.hand.cards.removeAll()
        dealerObject.setUpDealerHand()
        displayCards(dealerObject.hand.cards , playerCardView: dealerCardsView, yCord: 37 , dealerCard : true)
            //getLabel(index).text = playerArray[index].hand.getAllCards()
            
        
        //}
        
        
        
        
    }
    
    func displayCards(cards : [Int],  playerCardView : UIView, yCord : CGFloat , dealerCard : Bool ){
        var temp : CGFloat = 55
        var imageName : String
        for i in 1...cards.count{
            
            let testFrame : CGRect = CGRectMake( 1 + CGFloat(i-1)*temp, yCord,50,70)
            
            var testView : UIView = UIView(frame: testFrame)
            
            if(dealerCard && i==1){
                 imageName = "back"
            }
            else{
                
                 imageName = "card"+String(cards[i-1])
            }
            var image = UIImage(named: imageName)
            
            image = imageWithImage(image!, scaledToSize: CGSize(width: 50, height: 70))
            
            let imageView = UIImageView(image: image!)
            
            testView.addSubview(imageView)
            
            playerCardView.addSubview(testView)
            
        }
        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
    @IBAction func hit(sender: AnyObject) {
        if playerArray[0].hand.status == statusOfHand.turn {
            playerArray[0].getCardForHit()
            
            
            displayCards(playerArray[0].hand.cards, playerCardView : playerCards, yCord : 56 , dealerCard : dealerFlip)
            
            if (playerArray[0].hand.Blackjack()){
                gameStatus.text = "BLACKJACK !! Player Won"
                playerArray[0].hand.status = statusOfHand.blackjack
                value++
                if (value <= playerArray.count){
                    
                    playerArray[value].hand.status = statusOfHand.turn
                    
                }
                
            }
            else if (playerArray[0].hand.Busted()){
                gameStatus.text = "BUSTED !! PLAYER LOST"
               playerArray[0].hand.status = statusOfHand.busted
                value++
                if(value <=  playerArray.count){
                    
                    
                    playerArray[value].hand.status = statusOfHand.turn
                    //break
                }
                
                
                
            }
            
        }
    }
    
    
   
    
    
}

