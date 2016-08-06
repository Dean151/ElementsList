//
//  ViewController.swift
//  ElementsList
//
//  Created by Thomas Durand on 06/08/2016.
//  Copyright © 2016 Thomas Durand. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var elements: [Element] = []
    weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.title = "Periodic Elements"
        
        elements = try! Element.loadFromPlist()
        elements.sort(isOrderedBefore: {
            $0.atomicNumber < $1.atomicNumber
        })
        
        let tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        self.tableView = tableView
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Getting the right element
        let element = elements[indexPath.row]
        
        // Trying to reuse a cell
        let cellIdentifier = "ElementCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)

        // Adding the right informations
        cell.textLabel?.text = element.symbol
        cell.detailTextLabel?.text = element.name
        
        // Returning the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
