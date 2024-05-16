//
//  ViewController.swift
//  CoreDataLearning
//
//  Created by Izaan Saleem on 13/05/2024.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    private var manager = EmployeeManager()
    //private var employees: [Employee] = []
    
    private lazy var employeeDataProvider: EmployeeProvider =
    {
        let dataProvider = EmployeeProvider(With: self)
        return dataProvider
    }()

    //MARK: - view LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Employees"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(path)
        self.setupTableView()
        
        let btnAdd = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(self.addAction))
        let btnPassport = UIBarButtonItem(image: UIImage(systemName: "menucard"), style: .plain, target: self, action: #selector(self.passportAction))
        let btnVehicle = UIBarButtonItem(image: UIImage(systemName: "car.side"), style: .plain, target: self, action: #selector(self.vehicleAction))
        navigationItem.rightBarButtonItems = [btnAdd, btnPassport, btnVehicle]
        
        
        let btnAnimals = UIBarButtonItem(image: UIImage(systemName: "pawprint"), style: .plain, target: self, action: #selector(self.animalAction))
        navigationItem.leftBarButtonItem = btnAnimals
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //self.employees = self.manager.getAllEmployee() ?? []
        
        //self.tableView.reloadData()
    }
    
    //MARK: - Helper Methods
    private func setupTableView() {
        self.tableView.register(UINib(nibName: "EmployeeTableViewCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableViewCell")
    }
    
    //MARK: - @objc
    @objc func addAction() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController {
            vc.isFromEdit = false
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func passportAction() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PassportViewController") as? PassportViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func vehicleAction() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VehiclesViewController") as? VehiclesViewController {
            vc.seeAll = true
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    @objc func animalAction() {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnimalsViewController") as? AnimalsViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let obj = self.employeeDataProvider.fetchedResultController.object(at: indexPath) //self.employees[indexPath.row]
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { action, view, complete in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddEditViewController") as? AddEditViewController {
                vc.isFromEdit = true
                vc.empId = obj.id
                vc.vehicles = obj.toVehicle?.map({ cdVehicle in
                    return cdVehicle.convertToVehicle()
                }) ?? [] //obj.vehicles ?? []
                self.navigationController?.pushViewController(vc, animated: true)
            }
            complete(true)
        }
        edit.image = UIImage(systemName: "pencil")
        edit.backgroundColor = .blue
        
        let vehicle = UIContextualAction(style: .normal, title: "Vehicle") { action, view, complete in
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VehiclesViewController") as? VehiclesViewController {
                vc.vehicles = obj.toVehicle?.map({ cdVehicle in
                    return cdVehicle.convertToVehicle()
                }) ?? [] //obj.vehicles ?? []
                self.navigationController?.pushViewController(vc, animated: true)
            }
            complete(true)
        }
        vehicle.image = UIImage(systemName: "car")
        vehicle.backgroundColor = .brown
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { action, view, complete in
            if self.manager.deleteEmployee(byIdentifier: obj.id!) {
                self.tableView.reloadData()
            }
            complete(true)
        }
        delete.image = UIImage(systemName: "trash")
        delete.image?.withTintColor(.white)
        delete.backgroundColor = .red
        if obj.toVehicle?.count ?? 0 <= 0 {
            return UISwipeActionsConfiguration(actions: [delete, edit])
        } else {
            return UISwipeActionsConfiguration(actions: [delete, edit, vehicle])
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.employeeDataProvider.fetchedResultController.fetchedObjects?.count ?? 0 //self.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "EmployeeTableViewCell", for: indexPath) as? EmployeeTableViewCell {
            let obj = self.employeeDataProvider.fetchedResultController.object(at: indexPath) //self.employees[indexPath.row]
            if let profilePic = obj.profilePic {
                cell.imgProfilePic.image = UIImage(data: profilePic)
            }
            cell.lblName.text = obj.name
            cell.lblEmail.text = obj.email
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.reloadData()
    }
}
