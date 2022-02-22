//
//  AddToDoViewController.swift
//  ToDoCore
//
//  Created by Николай Никитин on 21.02.2022.
//

import UIKit

class AddToDoViewController: UIViewController {

  //MARK: - Properties
  var toDoTableViewController: ToDoTableViewController? = nil

  //MARK: - Outlets
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var prioritySegment: UISegmentedControl!

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Actions
  @IBAction func addTapped(_ sender: Any) {
    let newToDo = ToDo()
    newToDo.priority = prioritySegment.selectedSegmentIndex
    if let name = nameTextField.text {
      newToDo.name = name
    }
    toDoTableViewController?.toDos.append(newToDo)
    toDoTableViewController?.tableView.reloadData()
    navigationController?.popViewController(animated: true)
  }
}
