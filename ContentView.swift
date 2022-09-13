//
//  ContentView.swift
//  Who Pays?
//
//  Created by Даниил Пасечник on 28.10.2021.
//

import SwiftUI

struct ContentView: View {
//Изменение цвета шрифта в NavigationBar
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    
    @State private var kindOfAmount = ["Классический","Сложный"]
    @State private var idAmount = 0
    @State private var showInfo = false
    
    func showInfoView() {
        showInfo.toggle()
    }
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                Color(#colorLiteral(red: 0.3511006832, green: 0.4784158468, blue: 0.9606893659, alpha: 1))
                    .ignoresSafeArea()
                
// Выбор вида счета
                
                VStack {
                    
                    Text("Выбери счет на компанию:")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding(.top)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                    Picker(selection: $idAmount, label: Text("Picker")) {
                        ForEach(0..<kindOfAmount.count) { index in
                            Text(self.kindOfAmount[index])
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    Divider()
                        .padding(.bottom)
                    
                    if idAmount == 0 {
                        StackOne()
                    } else {
                        StackTwo()
                    }
                    Spacer()
                }
//Настройки NavigationBar
                .navigationBarTitle(Text("Пора подвести итог!")
                                        .foregroundColor(.white))

                .navigationBarItems(trailing: Button(action: {showInfoView()}) {
                    Image(systemName: "info.circle")
                        .foregroundColor(.white)
                        .font(.title2)
                })
                .sheet(isPresented: $showInfo, content: {
                    InfoView()
            })
            }
        }
    }
}
//Экран информации
struct InfoView: View{
    var body: some View {
        
        ZStack {
            Color(#colorLiteral(red: 0.3511006832, green: 0.4784158468, blue: 0.9606893659, alpha: 1))
                .ignoresSafeArea()
            VStack {
                
                Text("Классно погуляли?")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                    
                
                Text("Пора оплатить счет!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                
                Text("Наше приложение поможет тебе с этим справиться! 'Классический' счет поможет поделить один общий счет на все компанию. А 'Сложный' счет поможет в том случае, если уже несколько человек из компании уже оплатили все мероприятие, а счет нужно разделить поровну  на всех.")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 15)
                    .padding()
                
                Text("Удачи!")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                
            }
        }
    }
}
//Общий счет
struct StackOne: View {
    
    @State private var amount = ""
    @State private var numberOfPeople = ""
    @State private var tips = ""
    
    func getTotal() -> Double {
        
        guard let amounInDouble = Double(amount) else { return 0 }
        
        guard let tipsInDouble = Double(tips) else { return 0 }
        
        return amounInDouble + tipsInDouble
    }
    
    func getTotalPerPerson() -> Double {
        guard let numberOfPeopleInDouble = Double(numberOfPeople) else { return 0}
        
        return getTotal()/numberOfPeopleInDouble
    }
    
    var body: some View {
        VStack {
            HStack{
                
                Text("На сколько погуляли?")
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                
                Spacer()
                
                TextField("0", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 75)
                    .padding(.trailing)
            }
            HStack{
                
                Text("На сколько человек делим?")
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                
                Spacer()
                
                TextField("0", text: $numberOfPeople)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 75)
                    .padding(.trailing)
            }
            
            HStack {
                
                Text("Сколько оставим чаевых?")
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                
                Spacer()
                
                TextField("0", text: $tips)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 75)
                    .padding(.trailing)
            }
            
            Text("Итого вышло: \(lround(getTotal())) р")
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.white)
                .shadow(radius: 15)
            
            Text("Нужно скинуться по: \(lround(getTotalPerPerson())) р")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .shadow(radius: 15)
        }
    }
}
//Раздельный счет
struct StackTwo: View {
    
    @State private var totalPeople = ""
    @State private var numberOfPaying = ""
    @State private var arrayNumberOfPaying = [""]
    
    func getNumberOfPayingInInt() -> Int{
        guard let numOfPaingInInt = Int(numberOfPaying) else { return 1 }
        return numOfPaingInInt
    }
    var body: some View {
        
        ScrollView {
            VStack {
                HStack {
                    
                    Text("На сколько человек делим?")
                        .fontWeight(.semibold)
                        .shadow(radius: 15)
                        .padding()
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    TextField("0", text: $totalPeople)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 75)
                        .padding(.trailing)
                }
                HStack {
                    
                    Text("Сколько человек уже платили?")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .shadow(radius: 15)
                    
                    Spacer()
                    
                    TextField("0", text: $numberOfPaying)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 75)
                        .padding(.trailing)
                }
                if numberOfPaying != "" {
                    ForEach(0..<getNumberOfPayingInInt()) { index in
                        PayingPerson(indexOfPerson: index + 1, numOfPeple: totalPeople)
                    }
                }
                
            }
        }
        
    }
}
//Модель для раздельного счета
struct PayingPerson: View {
    
    @State private var sum = ""
    
    var indexOfPerson: Int
    var numOfPeple = ""
    
    func getSumPerPerson() -> Double {
        guard let sumInDouble = Double(sum) else { return 0 }
        guard let numOfPeopleInDouble = Double(numOfPeple) else { return 0}
        return sumInDouble / numOfPeopleInDouble
    }
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    
                    Text("Сколько заплатил \(indexOfPerson) человек?")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .shadow(radius: 15)
                    
                    Spacer()
                    
                    TextField("0", text: $sum)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 75)
                        .padding(.trailing)
                }
                
                Text("Все остальные должны скинуть ему по: \(lround(getSumPerPerson()))")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .shadow(radius: 15)
                
                Divider()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
