//
//  ViewController.swift
//  JSONTesting
//
//  Created by Nicholas Kearns on 4/13/20.
//  Copyright © 2020 Nicholas Kearns. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var films:[FilmEntry] = []
    
    
    
    var table: UITableView = {
        let t = UITableView()
        t.translatesAutoresizingMaskIntoConstraints = false
        t.rowHeight = 75
        return t
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDataFromFile("locations")
        setupTable()
        // Do any additional setup after loading the view.
        
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            table.reloadData()
        }
    }
    
    func setupTable() {
        self.view.addSubview(table)
        table.delegate = self
        table.dataSource = self
        table.register(TitleCell.self, forCellReuseIdentifier: "TitleCell")
        NSLayoutConstraint.activate([
            table.topAnchor.constraint(equalTo: self.view.topAnchor),
            table.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            table.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            table.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
        
    }
    
    
    func getDataFromFile(_ fileName:String) {
        let path = Bundle.main.path(forResource: fileName, ofType: ".json")
        if let path = path {
            let url = URL(fileURLWithPath: path)
            print(url)
            let contents = try? Data(contentsOf: url)
            do {
                if let data = contents,
                    let jsonResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [[String:Any]] {
                    for film in jsonResult{
                        let firstActor = film["actor_1"] as? String ?? ""
                        let locations = film["locations"] as? String  ?? ""
                        let releaseYear = film["release_year"] as? String  ?? ""
                        let title = film["title"] as? String  ?? ""
                        let movie = FilmEntry(firstActor: firstActor, locations: locations, releaseYear: releaseYear, title: title)
                        films.append(movie)
                        
                    }
                    print(films.count)
                    table.reloadData()
                    
                }
            } catch {
                print("Error deserializing JSON: \(error)")
            }
        }
        
    }
    
    
    
    
}
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell") as! TitleCell
        cell.label.text = films[indexPath.row].locations
        return cell
    }
    
    
  
    
    
}

