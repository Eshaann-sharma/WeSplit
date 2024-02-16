//
//  ContentView.swift
//  WeSplitting
//

import SwiftUI

struct ContentView: View {
    
    @State private var Amount = 0.0
    @State private var NoPeople = 2
    @State private var Tip = 15
    @FocusState private var AmountIsfocused : Bool
    
    let TipPercentage = [0,5,10,15,20]
    
    var TotalPerPerson: Double {
        let personcount = Double(NoPeople + 2 )
        let tipselected = Double(Tip)
        
        let tipvalue = (Amount/100)*tipselected
        let total = Amount+tipvalue
        let tpp = total/personcount
        
        return tpp
    }
    
    var TotalAmount: Double {
        let tipvalue = (Amount/100)*Double(Tip)
        let total = Amount+tipvalue
        return total
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount",
                              value: $Amount,
                              format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .keyboardType(.decimalPad)
                            .focused($AmountIsfocused)
                    Picker("Number Of People", selection: $NoPeople){
                        ForEach(2..<100){
                            Text("\($0)")
                        }
                    }
                }.navigationTitle("WeSplit")
                    
                
                Section{
                    Picker("Tip Percentage", selection: $Tip){
                        ForEach(TipPercentage, id: \.self){
                            Text($0,format: .percent)
                        }
                        .pickerStyle(.segmented)
                    }
                
                }
            header: {
                    Text("How much Tip you want to leave?")
                }
                
                Section{
                    Text(TotalAmount,format : .currency(
                        code:Locale.current.currency?.identifier ?? "USD"))
                }
            header: {
                Text("Total Amount")
            }
                
                Section{
                    Text (TotalPerPerson, format: .currency (code:
                                                                Locale.current.currency?.identifier ?? "USD" ))
                }
            header: {
                Text("Amount per Person")
            }
            }.toolbar {
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    Button("DONE"){
                        AmountIsfocused = false
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
