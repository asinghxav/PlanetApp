//
//  ViewController.swift
//  PlanetApp
//
//  Created by Abhishek Singh on 07/01/19.
//  Copyright © 2019 Abhishek Singh. All rights reserved.
//

import UIKit


protocol PlanetView : class
{
    func reloadTableView() -> ()
    func showActivityIndicator()
    func hideActivityIndicator()
}

class ViewController: UIViewController {

    @IBOutlet weak var tableViewPlanets: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!

    
    let identifier = "PlanetListCellIdentifier"
    
    var viewModel: PlanetViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
       
        let nib = UINib(nibName: "PlanetListTableViewCell", bundle: nil)
        tableViewPlanets.register(nib, forCellReuseIdentifier: identifier)
       
        viewModel = PlanetViewModel(view: self)
        viewModel?.fetchPlanetListfromDB()
        viewModel?.callPlanetListAPI()

    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (viewModel?.items.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableViewPlanets.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? PlanetListTableViewCell
        
        let itemViewModel = viewModel?.items[indexPath.row]
        
        cell?.configureCell(withViewModel: itemViewModel!)
        
        return cell!
    }
    
}

extension ViewController: PlanetView {
    
    func reloadTableView() {
        
        guard (viewModel?.items) != nil else {
            print("not item found")
            return
        }
        
        self.tableViewPlanets.reloadData()
    }
    
    func showActivityIndicator(){
        activityIndicatorView.isHidden = false
    }
    
    func hideActivityIndicator(){
        activityIndicatorView.isHidden = true
    }
}


