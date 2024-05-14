//
//  VehiclesViewController.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 14/05/2024.
//

import UIKit

class VehiclesViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var vehicles: [Vehicle] = []
    private var manager = VehicleManager()
    var seeAll: Bool = false

    //MARK: - view LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Vehicles"
        self.tableView.register(UINib(nibName: "VehiclesTableViewCell", bundle: nil), forCellReuseIdentifier: "VehiclesTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.seeAll {
            self.vehicles = self.manager.getAll() ?? []
            
            self.tableView.reloadData()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension VehiclesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
}

extension VehiclesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.vehicles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "VehiclesTableViewCell", for: indexPath) as? VehiclesTableViewCell {
            let obj = self.vehicles[indexPath.row]
            cell.lblCarName.text = "Vehicle: \(obj.name)"
            cell.lblType.text = "Type: \(obj.type)"
            return cell
        }
        return UITableViewCell()
    }
}
