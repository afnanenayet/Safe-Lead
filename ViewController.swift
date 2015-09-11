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
    
    func integerCheck() {
        if (team1_points.stringValue).toInt() == nil || (team2_points.stringValue).toInt() == nil || ((secondsRemaining.stringValue).toInt() == nil && (minutesRemaining.stringValue).toInt() == nil){
            submitProps.enabled = false
        }
            
        else {
            submitProps.enabled = true
        }
    }
    
    func compileTitle() { //gets name of each team and formats it for the window header
        if (team1_name.stringValue.isEmpty) && (team2_name.stringValue.isEmpty) {
            self.view.window!.title="Basketball Safe Lead Analyzer v1.0.0"
        }
        
        else {
            var titleString: String = "\(team1_name.stringValue) vs. \(team2_name.stringValue)"
            self.view.window!.title = titleString
        }
        
    }
    
    //Disable submit buttong until all required fields have valid integers
    @IBAction func checkPoints1(sender: AnyObject) {
        integerCheck()
    }
    
    
    @IBAction func checkPoints2(sender: AnyObject) {
        integerCheck()
    }
    
    @IBAction func checkSeconds(sender: AnyObject) {
        integerCheck()
    }
    
    
    @IBAction func submitButton(sender: AnyObject) { //performs action when submit button is clicked
        integerCheck() //make sure all inputs are valid
        var algorithmInstace = algorithm() //instantiating the algorithm class
        var teamPos = pos_who.selectedRow + 1 //get the team in posession
        var minutes: Int
        var seconds: Int
        
        if(minutesRemaining.stringValue).toInt() == nil && secondsRemaining.stringValue.toInt() != nil {
            minutes = 0
        }
            
        
        else {
            minutes = (minutesRemaining.stringValue).toInt()!
        }
        
        if(minutesRemaining.stringValue).toInt() != nil && secondsRemaining.stringValue.toInt() == nil {
            seconds = 0
        }
        
        else {
            seconds = (secondsRemaining.stringValue).toInt()!
        }
        
        var isLeadSafe = algorithmInstace.leadSafe((team1_points.stringValue).toInt()!,(team2_points.stringValue).toInt()!, seconds, minutes, teamPos)
        
        if isLeadSafe { //TODO: make a more elaborate message
            var outputString = "The lead is safe."
            outputField.stringValue = outputString
        }
        
        else { //TODO: make a more elaborate message
            outputField.stringValue = "The lead is not safe."
        }
    }
    
    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

