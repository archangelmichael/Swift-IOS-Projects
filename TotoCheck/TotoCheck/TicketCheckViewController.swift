//
//  TicketCheckViewController.swift
//  TotoCheck
//
//  Created by Radi on 6/2/15.
//  Copyright (c) 2015 archangel. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class TicketCheckViewController : UIViewController {
    var drawTitle : String = ""
    var drawnNumbersCount : Int = 0;
    var totalNumbersCount : Int = 0;
    var draws : [NSArray] = []
    var combinations : [Array<Int>] = []
    var bestCombinations : [Array<Int>] = []
    var winningCombinations : [Array<Int>] = []
    var errorMessage : String = ""
    
    private let cellsPerRow : Double = 7.0
    private let reuseIdentifier = "CustomCell"
    private let joiner = " \n "
    private let sectionInsets = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
    private var side = 0.0
    private var currentNumbers = [Int]()
    
    var threes : Int = 0
    var fours : Int = 0
    var fives : Int = 0
    var sixes : Int = 0
    
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawLabel.text = drawTitle
        
        // Set collection view options
        self.collectionView?.registerNib(UINib(nibName:"CustomCollectionViewCell", bundle: nil),
            forCellWithReuseIdentifier:reuseIdentifier)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let width = Double(collectionView.frame.width)
        let horizontalSpace = (cellsPerRow + 1) * 10 // Space for 7 equal cells on one row
        side = (width - horizontalSpace) / cellsPerRow
        let rows = totalNumbersCount / drawnNumbersCount
        let verticalSpace = Double((rows + 1) * 10)
        let height = Double(verticalSpace) + Double(rows) * side
        self.collectionView.frame  = CGRectMake(self.collectionView.frame.origin.x,
            self.collectionView.frame.origin.y,
            CGFloat(width),
            CGFloat(height))
    }
    
    @IBAction func onNumberClicked(sender: AnyObject) {
        let button = sender as! UIButton
        let numberClicked = button.titleLabel?.text
        println(numberClicked)
        if let index = find(currentNumbers, numberClicked!.toInt()!) {
            currentNumbers.removeAtIndex(index)
            button.backgroundColor = UIColor.whiteColor()
        }
        else {
            currentNumbers.append(numberClicked!.toInt()!)
            button.backgroundColor = UIColor.greenColor()
        }
        
        println("CURRENT NUMBERS: \(currentNumbers)")
    }
    
    @IBAction func onCheckTicket(sender: AnyObject) {
        currentNumbers.sort(self.sorterForFileIDASC)
        println(currentNumbers)
        
        if currentNumbers.count < drawnNumbersCount {
            // TODO: Show message invalid number of elements selected
            return
        }
        
        threes  = 0
        fours = 0
        fives = 0
        sixes = 0
        
        self.combinations = combinations(self.currentNumbers, k: drawnNumbersCount)
        var joinedStrings = joiner.join(self.combinations) // POSSIBLE DUE TO STRING EXTENSION
        println("ALL POSSIBLE COMBINATIONS: \(joinedStrings)")
        
        self.calculateMatches()
        
        var title : String = ""
        var message: String = ""
        let divider = " \n "
        if  (self.threes != 0 || self.fours != 0 || self.fives != 0 || self.sixes != 0) {
            if drawnNumbersCount == 6 && self.sixes != 0 {
                title = "YOU LUCKY BASTARD"
                message = "YOU ARE A MILLIONAIRE NOW \n WINNING COMBINATIONS \n \(divider.join(self.bestCombinations))"
            }
            else {
                title = "CONGRATULATIONS"
                message = "YOUR SCORE \n TOTAL COMBINATIONS: \(self.combinations.count) \n WINNING COMBINATIONS : \(self.winningCombinations.count) \n RESULTS : \n THREES : \(self.threes) \n FOURS : \(self.fours) \n FIVES : \(self.fives) \n COMBINATIONS \n \(divider.join(self.winningCombinations))"
            }
        }
        else {
            title = "SORRY. TRY AGAIN"
            message = "DONT GIVE UP"
        }
        
        self.showAlertView(title, message: message)
    }
    
    func sorterForFileIDASC(this:Int, that:Int) -> Bool {
        return this < that
    }
    
    func sliceArray<T>(var arr: Array<T>, x1: Int, x2: Int) -> Array<T> {
        var tt: Array<T> = []
        for var ii = x1; ii <= x2; ++ii {
            tt.append(arr[ii])
        }
        
        return tt
    }
    
    func combinations<T>(var arr: Array<T>, k: Int) -> Array<Array<T>> {
        var i: Int
        var subI : Int
        var ret: Array<Array<T>> = []
        var sub: Array<Array<T>> = []
        var next: Array<T> = []
        for var i = 0; i < arr.count; ++i {
            if(k == 1){
                ret.append([arr[i]])
            }
            else {
                let count = arr.count - 1
                let numbersLeft = k - 1
                sub = self.combinations(sliceArray(arr, x1:i + 1, x2: count), k: numbersLeft)
                for var subI = 0; subI < sub.count; ++subI {
                    next = sub[subI]
                    next.insert(arr[i], atIndex: 0)
                    ret.append(next)
                }
            }
        }
        
        return ret
    }
    
    func calculateMatches() {
        for draw in self.draws {
            for combination in self.combinations {
                var matchesCounter = 0
                for index in 0...(combination.count-1) {
                    let currentNumber = combination[index]
                    if draw.containsObject(currentNumber) {
                        matchesCounter++
                    }
                }
                
                if matchesCounter > 2 && matchesCounter < 7 {
                    self.winningCombinations.append(combination)
                }
                
                switch matchesCounter {
                case 3: self.threes++
                case 4: self.fours++
                case 5: self.fives++
                case 6:
                    self.sixes++
                    self.bestCombinations.append(combination)
                default: continue
                }
            }
        }
    }
    
    @IBAction func onGoBack(sender: AnyObject) {
        navigationController?.popViewControllerAnimated(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TicketCheckViewController : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalNumbersCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : CustomCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! CustomCollectionViewCell
        cell.numberButton.layer.cornerRadius = 10
        cell.numberButton.clipsToBounds = true
        cell.numberButton.setTitle(String(indexPath.row + 1), forState: UIControlState.Normal)
        
        cell.numberButton.setTitleColor(TOP_COLOR, forState: UIControlState.Normal)
        cell.numberButton.setTitleColor(BOTTOM_COLOR, forState: UIControlState.Selected)
        cell.numberButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Highlighted)
        cell.numberButton.addTarget(self, action:"onNumberClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
}

extension TicketCheckViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("SELECTED ROW \(indexPath.row)")
        // TODO: ADD ITEM TO ARRAY OF NUMBERS
    }
    
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        println("DESELECTED ROW \(indexPath.row)")
        // TODO: REMOVE ITEM FROM ARRAY OF NUMBERS
    }
}

extension TicketCheckViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: side, height: side)
    }
    
    // Set space around all items
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets {
            return sectionInsets
    }
    
    // Set space between items on one line
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }
    
    // Set space between separate lines
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10
    }

    func showAlertView(title: String, message: String) -> Void {
        let networkIssueController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
        networkIssueController.addAction(okButton)
        self.presentViewController(networkIssueController, animated: true, completion: nil)
    }
}

extension String {
    func join<S : SequenceType where S.Generator.Element : Printable>(elements: S) -> String {
        return self.join(map(elements){ $0.description })
    }
    
    // use this if you don't want it constrain to Printable
    //func join<S : SequenceType>(elements: S) -> String {
    //    return self.join(map(elements){ "\($0)" })
    //}
}