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
    
    @IBOutlet weak var player1Bet: UITextField!
    
    @IBOutlet weak var player2Bet: UITextField!
    
    @IBOutlet weak var dealerCardsView: UIView!
    
    
   
    
    @IBOutlet weak var gameStatus: UILabel!
    
    //Initialisation
    
    var deckObject = Deck()
     var dealerObject = Dealer()
    var noOfPlayers :Int = 1
    var playerArray :[Player] = []
    var dealerFlip : Bool = false
    
    var value : Int = 1
    
    var round : Int = 0
    
    var i1 : Int = 0
    var j1 : Int = 0
    
    var statusString : String = ""
   
    
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
                if(round > 0){
                    
            clearEverything()
        }
        round++
        //for var index = 0; index < noOfPlayers; ++index {
            
            
            var p = Player(name: "P\(0)", money:100 )
            playerArray.append(p)
        
        var p2 = Player(name: "P\(0)", money:100 )
            playerArray.append(p2)
        
        println("inside method \(0)")
            
        
        playerArray[1].hand.cards.removeAll()
        deckObject.shuffle();playerArray[0].setUpHand()
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
        
        gameStatus.text = "Game Started !!"
        
        
    }
    
    func displayCards(cards : [Int],  playerCardView : UIView, yCord : CGFloat , dealerCard : Bool ){
        var temp : CGFloat = 55
        var imageName : String
        
        var subViews = playerCardView.subviews
        
        
        
        
        for u in subViews as [UIView] {
            
            if (u.tag == 100){
                u.removeFromSuperview()
            }
        }


        for i in 1...cards.count{
            
            let testFrame : CGRect = CGRectMake( 1 + CGFloat(i-1)*temp, yCord,50,70)
            
            var testView : UIView = UIView(frame: testFrame)
            testView.tag = 100
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
            var subViews = playerCards.subviews
            
            gameStatus.text = "Do you wanna Hit or Stand ?"
            
            if (playerArray[0].hand.Blackjack()){
                gameStatus.text = "BLACKJACK !! Player Won"
                playerArray[0].hand.status = statusOfHand.blackjack
                stand()
            }
            else if (playerArray[0].hand.Busted()){
                //gameStatus.text = "BUSTED !! PLAYER LOST"
               playerArray[0].hand.status = statusOfHand.busted
                
                stand()
                
                
                
            }
            
        }
       
        
    }
    
    func getUITextField(var i : Int) -> UITextField {
        switch i {
            
        case 0 : return player1Bet
            
        case 1 : return player2Bet
            
                default :
            return player1Bet
            
        }
        
    }
    

    
    
    
    @IBAction func standButton(sender: AnyObject) {
        stand()
        
    }
    
        func callingDealer(){
        while(dealerObject.hand.score <= 16){
            dealerObject.setUpDealerAgainHand()
        }
        displayCards(dealerObject.hand.cards , playerCardView: dealerCardsView, yCord: 37 , dealerCard : dealerFlip)
        calculateBet()

    }
    
    func stand(){
        while(playerArray[1].hand.score <= 18){
            playerArray[1].getCardForHit()
        }
        displayCards(playerArray[1].hand.cards , playerCardView: aiCards, yCord: 46 , dealerCard : dealerFlip)
        
        if (playerArray[1].hand.Blackjack()){
            //gameStatus.text = "BLACKJACK !! Player Won"
            playerArray[1].hand.status = statusOfHand.blackjack
            
            
        }
        else if (playerArray[1].hand.Busted()){
            //gameStatus.text = "BUSTED !! PLAYER LOST"
            playerArray[1].hand.status = statusOfHand.busted
            
            
            
            
        }
        
        callingDealer()
    }
    

    
    func calculateBet() {
        
        
        
        for players in playerArray{
            
            if(dealerObject.hand.score > 21 && players.hand.score <= 21) {
                players.hand.money = players.hand.money + getUITextField(i1).text.toInt()!
            }
                
            else if (dealerObject.hand.score == 21 && dealerObject.hand.score > players.hand.score){
                
                players.hand.money = players.hand.money - getUITextField(i1).text.toInt()!
                
            }
                
            else if (dealerObject.hand.score == players.hand.score) && (dealerObject.hand.score <= 21 && players.hand.score <= 21 ){
                
            }
                
            else if (players.hand.status == statusOfHand.blackjack){
                players.hand.money = players.hand.money + getUITextField(i1).text.toInt()!
            }
            else if ( players.hand.status == statusOfHand.busted){
                players.hand.money = players.hand.money - getUITextField(i1).text.toInt()!
            }
                
            else if (players.hand.score < 21 && dealerObject.hand.score < 21 && players.hand.score > dealerObject.hand.score ){
                players.hand.money = players.hand.money + getUITextField(i1).text.toInt()!
            }
            else if (players.hand.score < 21 && dealerObject.hand.score < 21 && players.hand.score < dealerObject.hand.score ){
                players.hand.money = players.hand.money - getUITextField(i1).text.toInt()!
            }
            
            
            i1++
            
        }
        
        
        for p in playerArray{
            
            var playerStatus : String = "P\(j1+1) has \(p.hand.money)"
            statusString = statusString + "  " + playerStatus
            j1++
        }
       
        
        gameStatus.text = statusString
        
            }
    
    func clearEverything(){
        var k : Int = 0
        //round++
        
        playerArray[0].hand.cards.removeAll()
        playerArray[1].hand.cards.removeAll()
        dealerObject.hand.cards.removeAll()
        
        
        for p in playerArray{
            
            
            
            getUITextField(k).text = ""
            //dealerCards.text = ""
            gameStatus.text = ""
                        k++
        }
        
        
        value = 0
        i1 = 0
        j1 = 0
        
        if (round > 5){
            round = 0
            deckObject.shuffle()
        }
        //roundCount.text = "Round \(round)"
        
        
        
    }

    

   
    
    
}

