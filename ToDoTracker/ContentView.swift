//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var taskGroups = TaskGroup.sampleData
    @State private var selectedGroup: TaskGroup?
    //Core difference between iPhone and iPad
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    
    var body: some View {
        NavigationSplitView(columnVisibility: $columnVisibility) {
            //Column 1: let of navigation
            List(selection: $selectedGroup) {
                ForEach(taskGroups) {group in
                    NavigationLink(value: group) {
                        Label(group.title, systemImage: group.symbolName)
                    }
                }
            }
            .navigationTitle("")
            
        } detail: {
            if let selectedGroup = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == selectedGroup.id}) {
                    TaskGroupDetailView(group: $taskGroups [index])
                }else{
                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
                }
            }
        }
        
    }
}
