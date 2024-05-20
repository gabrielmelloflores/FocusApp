import SwiftUI

struct BlockView: View {
    @State private var isSwitchOn: Bool = false
    @State private var fromTime = Date()
    @State private var toTime = Date().addingTimeInterval(3600) // adiciona uma hora
    @State private var selectedDays: Set<Weekday> = [.monday, .tuesday, .wednesday, .thursday, .friday]
   
    let weekDays = [Weekday.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            
            List {
                Section {
                    Toggle("Work Time", isOn: $isSwitchOn)
                        .foregroundColor(.white)
                }
               
                Section(header: Text("Apps Blocked").foregroundColor(.white)) {
                    NavigationLink(destination: Text("App Group").foregroundColor(.white)) {
                        Text("App Group")
                            .foregroundColor(.white)
                    }
                }
               
                Section(header: Text("Difficulty").foregroundColor(.white)) {
                    NavigationLink(destination: Text("Timeout").foregroundColor(.white)) {
                        Text("Timeout")
                            .foregroundColor(.white)
                    }
                }
               
                Section(header: Text("There will be increasing delays before you can snooze again").foregroundColor(.white)) {
                    DatePicker("From", selection: $fromTime, displayedComponents: .hourAndMinute)
                        .foregroundColor(.white)
                    DatePicker("To", selection: $toTime, displayedComponents: .hourAndMinute)
                        .foregroundColor(.white)
                }
               
                Section {
                    WeekdayPicker(selectedDays: $selectedDays)
                }
               
                Section {
                    Button(action: {
                        // Ação para salvar as configurações
                    }) {
                        Text("Save")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.green)
                   
                    Button(action: {
                        // Ação para deletar a sessão
                    }) {
                        Text("Delete Session")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .listRowBackground(Color.red)
                }
            }
            .listStyle(GroupedListStyle())
            .background(Color.black) // Define o fundo da lista como preto
        }
        .colorScheme(.dark) // Aplica o modo escuro
    }
}

struct WeekdayPicker: View {
    @Binding var selectedDays: Set<Weekday>
    
    let weekDays = ["S", "M", "T", "W", "T", "F", "S"]
    
    var body: some View {
        HStack {
            ForEach(0..<7, id: \.self) { index in
                Text(self.weekDays[index])
                    .foregroundColor(self.selectedDays.contains(Weekday.allCases[index]) ? .white : .gray)
                    .frame(width: 35, height: 35)
                    .background(self.selectedDays.contains(Weekday.allCases[index]) ? Color.blue : Color.black)
                    .clipShape(Circle())
                    .onTapGesture {
                        let day = Weekday.allCases[index]
                        if self.selectedDays.contains(day) {
                            self.selectedDays.remove(day)
                        } else {
                            self.selectedDays.insert(day)
                        }
                    }
            }
        }
    }
}

enum Weekday: CaseIterable {
    case sunday, monday, tuesday, wednesday, thursday, friday, saturday
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        BlockView()
    }
}
