//
//  NewGroupView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/7/26.
//

import SwiftUI


struct NewGroupView: View {
    
    @State private var groupName = ""
    @State private var selectedIcon = "list.bullet"
    let icons = ["list.bullet", "bookmark.fill", "star", "house.fill", "heart.fill", "duffle.bag.fill"]
    
    @Environment(\.dismiss) var dismiss
    var onSave: (TaskGroup) -> Void
    
    var body: some View {
        NavigationStack {
            Form {
                //section: Group Name
                Section("Group Name"){
                    TextField("e.g., Work, School", text: $groupName)
                }
                
                //section2: Selected icon
                Section("Seclect Icon"){
                    LazyVGrid(columns: [GridItem(.adaptive(minimum:40))]){
                        ForEach(icons, id: \.self) { icon in
                            Image(systemName: icon)
                                .font(.title2)
                                .frame(width: 40, height: 40)
                                .background(selectedIcon == icon ? Color.pink.opacity(0.2) : Color.clear)
                                .foregroundStyle(selectedIcon == icon ? Color.blue : Color.gray)
                                .clipShape(Circle())
                                .onTapGesture {
                                    selectedIcon = icon
                                }
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("New Group")
            .toolbar {
                ToolbarItem(placement: .cancellationAction){
                    Button("Cancel"){dismiss()}
                }
                
                ToolbarItem(placement: .confirmationAction){
                    Button("Save"){
                        let newGroup = TaskGroup(title: groupName, symbolName: selectedIcon, tasks: [] )
                        onSave(newGroup)
                        dismiss()
                        
                    }
                }
            }
        }
    }
}
