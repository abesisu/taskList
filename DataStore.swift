//
//  File.swift
//  Task List
//
//  Created by Abe Scheideman on 7/15/21.
//

import Foundation
import SwiftUI
import Combine // Helps to combine data from one file to another

struct Task : Identifiable {
    var id = String()
    var toDoItem = String() // this task is something that is going to be observed by swiftui. need to put tasks into an object to be observed in the future
    
    // Add more stuff later if you want
}

// object to bind the tasks to the list
class TaskStore : ObservableObject {
    @Published var tasks = [Task]()
}
