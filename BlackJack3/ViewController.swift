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
    @IBOutlet weak var playercard1: UIImageView!
    
    //Initialisation
    
    var d = Deck()
    var noOfPlayers :Int = 1
    var playerArray :[Player] = []
    
    
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
        
        d.dealCard(2)
        
        for var index = 0; index < noOfPlayers; ++index {
            
            
            var p = Player(name: "P\(index)", money:100 )
            playerArray.append(p)
            
            println("inside method \(index)")
            
            
            playerArray[index].setUpHand()
            
            //getLabel(index).text = playerArray[index].hand.getAllCards()
            
            displayCards(playerArray[index].hand.cards)
            
        }
        
        
        
        
    }
    
    func displayCards(cards : [Int]){
        var temp : CGFloat = 35
        for i in 1...cards.count{
            
            let testFrame : CGRect = CGRectMake( 35 + CGFloat(i-1)*temp,56,27,40)
            
            var testView : UIView = UIView(frame: testFrame)
            
            let imageName = "card2"
            
            var image = UIImage(named: imageName)
            
            image = imageWithImage(image!, scaledToSize: CGSize(width: 27, height: 40))
            
            let imageView = UIImageView(image: image!)
            
            testView.addSubview(imageView)
            
            playerCards.addSubview(testView)
            
        }
        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        image.drawInRect(CGRectMake(0, 0, newSize.width, newSize.height))
        var newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    
}

