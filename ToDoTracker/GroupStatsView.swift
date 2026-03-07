//
//  GroupStatsView.swift
//  ToDoTracker
//
//  Created by Ken Gonzalez on 3/7/26.
//

import SwiftUI


struct GroupStatsView: View {
    
    var tasks: [TaskItem]
    var completedCount: Int { tasks.filter {$0.isCompleted}.count }
    
    var progress: Double { tasks.isEmpty ? 0 : Double(completedCount) / Double(tasks.count)} //Percentage: 50%, 70%
    
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10)
                    .opacity(0.3)
                    .foregroundColor(.blue)
                
                Circle()
                    .trim(from: 0.0, to: progress)
                    .stroke(style: StrokeStyle(lineWidth: 10))
                    .foregroundColor(.blue)
                    .rotationEffect(.degrees(-90))
                
                Text("\(Int(progress * 100))%")
            }
            frame(width: 60, height: 60)
            .padding()
            
            VStack(alignment: .leading){
                Text("Task Progress")
                Text("\(completedCount) / \(tasks.count) Completed")
            }
        }
        .padding()
        .background(Color(.secondarySystemBackground))
    }
}
