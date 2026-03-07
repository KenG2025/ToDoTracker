//
//  TaskGroupDetailView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/3/26.
//

//Details that are shown on the right side of the iPad

import SwiftUI



struct TaskGroupDetailView: View {
    
    @Binding var group: TaskGroup
    //@State - same view
    //@Binding - parent view
    @Environment(\.horizontalSizeClass) var sizeClass
    
    
    var body: some View {
        List {
            Section {
                if sizeClass == .regular {
                    GroupStatsView(tasks: group.tasks)
                        .listRowInsets(EdgeInsets())
                        .listRowBackground(Color(.secondarySystemBackground))
                }
            }
            
            ForEach($group.tasks) {$task in
                HStack {
                    Image(systemName: task.isCompleted ? "checkmark.fill" : "circle")
                        .onTapGesture {
                            withAnimation{
                                task.isCompleted.toggle()
                            }
                        }
                    TextField("Task title", text:$task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundStyle(task.isCompleted ? .gray : .primary)
                }
            }
            .onDelete{ index in
                group.tasks.remove(atOffsets: index)
            }
        }
        .navigationTitle(group.title)
        .toolbar {
            Button("Add Task") {
                withAnimation{
                    group.tasks.append(TaskItem(title: ""))
                }
            }
        }
    }
    
}
