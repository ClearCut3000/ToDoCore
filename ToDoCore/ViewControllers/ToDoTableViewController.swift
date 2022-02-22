//
//  ToDoTableViewController.swift
//  ToDoCore
//
//  Created by Николай Никитин on 21.02.2022.
//

import UIKit

class ToDoTableViewController: UITableViewController {

  //MARK: - Properties
  var toDos: [ToDo] = []

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDos.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let selectedToDo = toDos[indexPath.row]
    if selectedToDo.priority == 1 {
      cell.textLabel?.text = "❗️" + selectedToDo.name
    } else if selectedToDo.priority == 2 {
      cell.textLabel?.text = "‼️" + selectedToDo.name
    } else {
      cell.textLabel?.text = selectedToDo.name
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedToDo = toDos[indexPath.row]
    performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
  }

  //MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let addToDoTableViewController = segue.destination as? AddToDoViewController {
      addToDoTableViewController.toDoTableViewController = self
    }
    if let detailToDoViewController = segue.destination as? ToDoDetailsViewController {
      if let selectedToDo = sender as? ToDo {
        detailToDoViewController.toDo = selectedToDo
      }
    }
  }
}
