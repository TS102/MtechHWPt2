//
//  ContentView.swift
//  CoreDataEvent
//
//  Created by Tyler Sun on 12/9/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        NavigationView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                    }  label: {
                        // put it inside of a hstack which puts it in a horizontal line.
                        HStack {
                            Text(item.timestamp!, formatter: itemFormatter)
                            
                            Spacer()
                            // update Ui to show a checkmark for the item that has even numbers and seconds is true
                            if item.hasEvenMinutesAndSeconds {
                                Image(systemName: "checkmark").foregroundColor(.green)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }

    private func addItem() {
        withAnimation {
            let now = Date.now
            let newItem = Item(context: viewContext)
            newItem.timestamp = now
            // MARK: this makes sure if the property is correct when we create a new item
            newItem.hasEvenMinutesAndSeconds = dateIsAllEven(now)// figures out if the item has an even number of min and seconds and save it to the item.
            try? viewContext.save()
            
            do {
                try viewContext.save()
            } catch {
    
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    // MARK: new func to determine if a date has an even number for min and seconds
    private func dateIsAllEven(_ date: Date) -> Bool {
        let minutes = Calendar.current.component(.minute, from: date)
        let seconds = Calendar.current.component(.second, from: date)
        let minutesAreEven = minutes % 2 == 0
        let secondsAreEven = seconds % 2 == 0
        return minutesAreEven && secondsAreEven
        
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
