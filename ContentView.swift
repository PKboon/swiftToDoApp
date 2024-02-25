import SwiftUI

struct ContentView: View {
  @State var list:[String] = ["Luandry"]
  @State var showTextField:Bool = false
  @State var newTask:String = ""

  var body: some View {
    @State var repeatedTask:Bool = self.list.contains(self.newTask)
    @State var disabledButton = repeatedTask || self.newTask.isEmpty

    VStack {
      VStack {
        Text("TODO List")
          .font(.largeTitle)
        if !self.list.isEmpty {
          Text(String(self.list.count) + " task" + (self.list.count > 1 ? "s" : ""))
        }
      }.padding()

      Button(action:{
        self.showTextField = !self.showTextField
        self.newTask = ""
      }) {
        Text(self.showTextField ? "Cancel" : "New Task")
      }.foregroundColor(.blue)

      if self.list.isEmpty && !showTextField {
        Text("Use the New button to get started").padding()
      }

      if self.showTextField {
        VStack{
          HStack{
            TextField("Enter a task", text: $newTask)
            Button(action:{
              self.list.append(self.newTask)
              self.newTask = ""
            }) {
              Text("Submit")
            }.foregroundColor(.white)
             .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 30)
             .background(disabledButton ? Color.gray : Color.blue)
             .cornerRadius(8)
             .disabled(disabledButton)
          }
          if repeatedTask {
            Text("This task is already on the list")
              .foregroundColor(.red)
          }
        }.padding()
      }

      List {
        ForEach(list, id: \.self) { item in
          HStack(alignment: .top) {
            Text(item)
            Spacer()
            Button(action: {
              self.list = self.list.filter { task in
                return task != item
              }
            }) {
              Text("Delete").foregroundColor(.red)
            }
          }
        }
      }
    }
  }
}
