//
//  Element.swift
//  ElementsList
//
//  Created by Thomas Durand on 06/08/2016.
//  Copyright © 2016 Thomas Durand. All rights reserved.
//

import Foundation

struct Element {
    enum State: String {
        case Solid, Liquid, Gas, Artificial
    }
    
    let atomicNumber: Int
    let atomicWeight: Float // in g.mol-1
    let discoveryYear: String
    let group: Int
    let name: String
    let period: Int
    let radioactive: Bool
    let state: State
    let symbol: String
    
    // Position in the table
    let horizPos: Int
    let vertPos: Int
}

extension Element {
    enum Error: ErrorProtocol {
        case noPlistFile
        case cannotReadFile
    }
    
    /// Load all the elements from the plist file
    static func loadFromPlist() throws -> [Element] {
        // First we need to find the plist
        guard let file = Bundle.main.pathForResource("Elements", ofType: "plist") else {
            throw Error.noPlistFile
        }
        
        // Then we read it as an array of dict
        guard let array = NSArray(contentsOfFile: file) as? [[String: AnyObject]] else {
            throw Error.cannotReadFile
        }
        
        // Initialize the array
        var elements: [Element] = []
        
        // For each dictionary
        for dict in array {
            // We implement the element
            let element = Element.from(dict: dict)
            // And add it to the array
            elements.append(element)
        }
        
        // Return all elements
        return elements
    }
    
    /// Create an element corresponding to the given dict
    static func from(dict: [String: AnyObject]) -> Element {
        let atomicNumber = dict["atomicNumber"] as! Int
        let atomicWeight = Float(dict["atomicWeight"] as! String) ?? 0
        let discoveryYear = dict["discoveryYear"] as! String
        let group = dict["group"] as! Int
        let name = dict["name"] as! String
        let period = dict["period"] as! Int
        let radioactive = dict["radioactive"] as! String == "True"
        let state = State(rawValue: dict["state"] as! String)!
        let symbol = dict["symbol"] as! String
        let horizPos = dict["horizPos"] as! Int
        let vertPos = dict["vertPos"] as! Int
        
        return Element(atomicNumber: atomicNumber,
                       atomicWeight: atomicWeight,
                       discoveryYear: discoveryYear,
                       group: group,
                       name: name,
                       period: period,
                       radioactive: radioactive,
                       state: state,
                       symbol: symbol,
                       horizPos: horizPos,
                       vertPos: vertPos)
    }
}
