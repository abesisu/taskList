//
//  ContentView.swift
//  Task List
//
//  Created by Abe Scheideman on 7/15/21.
//

import SwiftUI
import Combine

//Things possible to add: Save items in the background, make it so the tasks can be "done" when deleted,

struct ContentView: View {
    // Creating a variable off of the class built
    @ObservedObject var taskStore = TaskStore()
    // variable for the searchBar TextField
    @State var newToDo : String = ""
    
    // a search bar that people can type into
    var searchBar : some View {
        HStack {
            // Binding<String> - as the text field is being edited, it will bind with the variable put into it and change the variable as you are typing in the TextField
            TextField("Enter a new task", text: self.$newToDo)
            // Button to take text from TextField and add into tasks object
            Button(action: self.addNewToDo, label: {
                Text("Add New")
            })
        }
    }
    
    // putting new Item into taskStore
    func addNewToDo() {
        // id makes a unique id for each task entered
        taskStore.tasks.append(Task(id: String(taskStore.tasks.count + 1), toDoItem: newToDo))
        // automatically resets the text field after pressing the Add New
        self.newToDo = ""
        // add auto generated id in the future
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // putting the search bar into UI
                searchBar.padding()
                // Actually using the published and observing the object inside
                List {
                    // observes the observable object and edits the code according to it - adds for variety of deleting and moving and other things
                    ForEach(self.taskStore.tasks) { task in
                        Text(task.toDoItem)
                    }.onMove(perform: self.move)
                        .onDelete(perform: self.delete)
                }.navigationBarTitle("Tasks")
                .navigationBarItems(trailing: EditButton())
            }
        }
    }
    
    //IndexSet says exactly where the thing is that is being moved
    func move(from source : IndexSet, to destination : Int) {
        taskStore.tasks.move(fromOffsets: source, toOffset: destination)
    }
    
    // delete function
    func delete(at offsets : IndexSet) {
        taskStore.tasks.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
