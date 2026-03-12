//
//  ContentView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/3/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var taskGroups: [TaskGroup] = []
    @State private var selectedGroup: TaskGroup?
    //Core difference between iPhone and iPad
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var isShowingAddGroup = false
    @Environment(\.scenePhase) private var scenePhase
    let saveKey = "saveTaskGroups"
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    @AppStorage("isDarkModeOff") private var isDarkModeOff = false
    //MARK: Have a dark mode feature added into your app
    //@AppStorage: To modify to complete behavior of fyour applicaton
    
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
            .navigationTitle("ToDo App")
            .listStyle(.sidebar)
            .toolbar {
                ToolbarItem(placement: .primaryAction){
                    Button {
                        isShowingAddGroup = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    
                }
                ToolbarItem(placement: .topBarLeading){
                    Toggle(isOn: $isDarkMode) {
                        Image(systemName: "moon.fill")
                        
                    }
                }
            }
            
        } detail: {
            if let selectedGroup = selectedGroup {
                if let index = taskGroups.firstIndex(where: { $0.id == selectedGroup.id}) {
                    TaskGroupDetailView(group: $taskGroups [index])
                }else{
                    ContentUnavailableView("Select a Group", systemImage: "sidebar.left")
                }
            }
        }
        //        .preferredColorScheme(isDarkMode ? .dark : .light )
        //        .toolbar {
        //            Toggle(isOn: $isDarkMode){
        //                Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
        //            }
        //        }
        .sheet(isPresented: $isShowingAddGroup){
            NewGroupView {newGroup in
                taskGroups.append(newGroup)
                selectedGroup = newGroup}
        }
        .onAppear{
            loadData() //New function
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            if newValue == .active{
                print("app is active")
            }else if newValue == .inactive {
                print("App is inactive")
            }else if newValue == .background {
                print("Background state, saving data...")
                saveData() //New function
            }
            
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
    func loadData() {
        if let saveData = UserDefaults.standard.data(forKey: saveKey){
            if let decodedGroups = try? JSONDecoder().decode([TaskGroup].self, from: saveData){
                taskGroups = decodedGroups
                return //Success
            }
        }
        taskGroups = TaskGroup.sampleData //Default data if there is no data
    }
    
    func saveData() {
        if let encodedGroups = try? JSONEncoder().encode(taskGroups){
            UserDefaults.standard.set(encodedGroups, forKey: saveKey)
        }
    }
    
    
}
