//
//  ToDoTableViewController.swift
//  ToDoCore
//
//  Created by Николай Никитин on 21.02.2022.
//

import UIKit

class ToDoTableViewController: UITableViewController {

  //MARK: - Properties
  var toDoCDs: [ToDoCD] = []

  //MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func viewWillAppear(_ animated: Bool) {
    getToDoCDs()
  }

  //MARK: - Methods
  func getToDoCDs() {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
      if let toDosFromCoreData = try? context.fetch(ToDoCD.fetchRequest()) {
        if let toDos = toDosFromCoreData as? [ToDoCD] {
          toDoCDs = toDos
          tableView.reloadData()
        }
      }
    }
  }

  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return toDoCDs.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    let selectedToDo = toDoCDs[indexPath.row]
    if selectedToDo.priority == 1 {
      if let name = selectedToDo.name {
        cell.textLabel?.text = "❗️" + name
      }
    } else if selectedToDo.priority == 2 {
      if let name = selectedToDo.name {
        cell.textLabel?.text = "‼️" + name
      }
    } else {
      if let name = selectedToDo.name {
        cell.textLabel?.text = name
      }
    }
    if let data = selectedToDo.image {
      cell.imageView?.image = UIImage(data: data)
    }
    return cell
  }

  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedToDo = toDoCDs[indexPath.row]
    performSegue(withIdentifier: "moveToDetails", sender: selectedToDo)
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let selectedToDo = toDoCDs[indexPath.row]
        context.delete(selectedToDo)
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        getToDoCDs()
      }
    }
  }

  //MARK: - Navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let addToDoTableViewController = segue.destination as? AddToDoViewController {
      addToDoTableViewController.toDoTableViewController = self
    }
    if let detailToDoViewController = segue.destination as? ToDoDetailsViewController {
      if let selectedToDo = sender as? ToDoCD {
        detailToDoViewController.toDoCD = selectedToDo
      }
    }
  }
}
