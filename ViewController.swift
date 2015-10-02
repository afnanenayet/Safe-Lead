//
//  ViewController.swift
//  Safe Lead
//
//  Created by Afnan Enayet on 9/9/15.
//  Copyright (c) 2015 Afnan Enayet. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var team1_name: NSTextField! //value of string in team1 textbox
    
    @IBOutlet weak var team2_name: NSTextField! //value of string in team2 textbox
    
    @IBOutlet weak var team1_points: NSTextField! //number of points team 1 has
    
    @IBOutlet weak var team2_points: NSTextField! //number of points team 2 has
    
    @IBOutlet weak var pos_who: NSMatrix! //First radio = team 1, second radio = team 2
    
    @IBOutlet weak var minutesRemaining: NSTextField! //how many minutes are remaining
    
    @IBOutlet weak var secondsRemaining: NSTextField! //how many seconds are remaining on top of the minutes
    
    @IBOutlet weak var outputField: NSTextField! //output field where we declare the safe lead
    
    @IBOutlet weak var submitProps: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitProps.enabled = false
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
        self.view.window!.title = "Basketball Safe Lead Analyzer v1.0.0"
    }
    
    @IBAction func finishEditTeam1(sender: AnyObject) { //when user finishes editing name textfield, window header will update
        compileTitle()
    }
    
    
    @IBAction func finishEditTeam2(sender: AnyObject) { //when user finishes editing second name textfield, window header will update
        compileTitle()
    }
    
    func integerCheck() -> Bool { //checks to see if inputs that need integers have integers
        if Int((team1_points.stringValue)) == nil || Int((team2_points.stringValue)) == nil || (Int((secondsRemaining.stringValue)) == nil && Int((minutesRemaining.stringValue)) == nil){
            return false
        }
            
        else {
            return true
        }
        
    }
    
    func buttonCheck() {
        if integerCheck() {
            submitProps.enabled = true
        }
        
        else {
            submitProps.enabled = false
        }
    }
    
    func compileTitle() { //gets name of each team and formats it for the window header
        if (team1_name.stringValue.isEmpty) && (team2_name.stringValue.isEmpty) {
            self.view.window!.title="Basketball Safe Lead Analyzer v1.0.0"
        }
        
        else {
            let titleString: String = "\(team1_name.stringValue) vs. \(team2_name.stringValue)"
            self.view.window!.title = titleString
        }
        
    }
    
    func validityPopup() { //shows a popup box to inform the user they entered invalid input
        let alert:NSAlert = NSAlert();
        alert.messageText = "Invalid input";
        alert.informativeText = "Make sure you typed in numbers for all of the input fields for score and time remaining.";
        alert.runModal();
    }
    
    //Disable submit buttong until all required fields have valid integers
    @IBAction func checkPoints1(sender: AnyObject) {
        buttonCheck()
    }
    
    
    @IBAction func checkPoints2(sender: AnyObject) {
       buttonCheck()
    }
    
    @IBAction func checkSeconds(sender: AnyObject) {
        buttonCheck()
    }
    
    
    @IBAction func submitButton(sender: AnyObject) { //performs action when submit button is clicked
        let algorithmInstace = algorithm() //instantiating the algorithm class
        let teamPos = pos_who.selectedRow + 1 //get the team in posession
        var minutes: Int
        var seconds: Int
        
        if integerCheck() {
            //if the user leaves minutes blank but not seconds, we assume minutes are 0 and vice versa
            if (Int((minutesRemaining.stringValue)) == nil && Int(secondsRemaining.stringValue) != nil) {
                minutes = 0
            }
                
                
            else {
                minutes = Int((self.minutesRemaining.stringValue))!
            }
            
            if Int((minutesRemaining.stringValue)) != nil && Int(secondsRemaining.stringValue) == nil {
                seconds = 0
            }
                
            else {
                seconds = Int((self.secondsRemaining.stringValue))!
            }
            
            integerCheck() //make sure all inputs are valid
            
            let isLeadSafe = algorithmInstace.leadSafe(Int((team1_points.stringValue))!,Int((team2_points.stringValue))!, seconds, minutes, teamPos)
            
            if isLeadSafe { //TODO: make a more elaborate message
                let outputString = "The lead is safe."
                outputField.stringValue = outputString
            }
                
            else { //TODO: make a more elaborate message
                outputField.stringValue = "The lead is not safe."
            }

        }
        
        else {
            validityPopup();
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

