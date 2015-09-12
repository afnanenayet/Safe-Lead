//
//  algorithm.swift
//  Safe Lead
//
//  Created by Afnan Enayet on 9/9/15.
//  Copyright (c) 2015 Afnan Enayet. All rights reserved.
//

import Foundation

class algorithm {
    func leadSafe (team1_points: Int, _ team2_points: Int, _ secondsRemaining: Int, _ minutesRemaining: Int, _ posTeam: Int) -> Bool {
        var leadScore: Double //converting to a Double because 0.5 will be added or subtracted later in the function
        let oneLead: Bool //is true if team 1 is in the lead
        let secondsTotal = secondsRemaining + (minutesRemaining*60) //converts minutes, seconds to seconds
        
        //find the magnitude of the lead then subtract 3
        if team1_points > team2_points { //if team 1 is in the lead
            oneLead = true
            leadScore = Double(team1_points - team2_points) - 3 //must make all vars same type (Double) to perform calculations
        }
        
        else { //if team 2 is in the lead
            oneLead = false
            leadScore = Double(team2_points - team1_points) - 3 //must make all variables same type (Double)
        }
        
        //if the team that is in possession is also in the lead, we add 0.5
        if (posTeam == 1 && oneLead == true) || (posTeam == 2 && oneLead == false) {
            leadScore = leadScore + 0.5
        }
        
        //if the team that is in the lead doesn't have possession, we subtract 0.5
        else  {
            leadScore = leadScore - 0.5
        }
        
        //if the value is less than 0, change it to 0
        if leadScore < 0 {
            leadScore = 0
        }
        
        //square the value
        leadScore = pow(leadScore, 2)
        
        //if the squared value is more than the number of seconds remaining, then the lead is safe
        if leadScore > Double(secondsTotal) {
            return true
        }
        
        //otherwise, the lead is not safe
        else {
            return false
        }
    }
}
