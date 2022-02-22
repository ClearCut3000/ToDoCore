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
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      let newToDo = ToDoCD(context: context)
      newToDo.priority = Int32(prioritySegment.selectedSegmentIndex)
      if let name = nameTextField.text {
        newToDo.name = name
      }
      (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
      navigationController?.popViewController(animated: true)
    }
  }
}
