//
//  ContentView.swift
//  Calculator
//
//  Created by m on 17/06/1443 AH.
//

import SwiftUI

enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case add = "+"
    case subtract = "-"
    case divide = "÷"
    case mutliply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    case negative = "-/+"
    
    var buttonColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return .orange
        case .clear, .negative, .percent:
            return Color(.lightGray)
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

struct ContentView: View {
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .mutliply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .add],
        [.zero, .decimal, .equal],
    ]
    @State var ToggleBool = false
    var body: some View {
        ZStack {
            Color("BackGround")
                .ignoresSafeArea()
            VStack {
                Toggle("", isOn: $ToggleBool)
                    .animation(.spring())
                    .toggleStyle(CustomToggle())
                    .frame(maxWidth:.infinity , alignment:.leading)
                    .padding()
                Text("0")
                    .font(.system(size:52))
                    .bold()
                    .foregroundColor(Color("Yellow"))
                    .frame(maxWidth:.infinity , alignment:.trailing)
                    .padding()
                ForEach(self.buttons , id: \.self) { row in
                    HStack{
                        ForEach(row , id: \.self) { button in
                            Button(action:{
                                
                            }) {
                                if button.rawValue == "=" {
                                    Text(button.rawValue)
                                        .font(.title)
                                        .foregroundColor(Color("Yellow"))
                                        .frame(width: 200 , height:50).background(Color("Gray").opacity(0.3).cornerRadius(15))
                                }
                                
                            }
                        }
                    }
                }
            }
        }.preferredColorScheme(ToggleBool ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13 Pro")
    }
}

struct CustomToggle : ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(width:30 ,height: 60)
                .foregroundColor(configuration.isOn ? Color.black : Color("Yellow"))
            Circle()
                .frame(width: 25)
                .offset(y: configuration.isOn ? -14 : 14)
                .foregroundColor(configuration.isOn ? Color("Yellow") : Color("Gray"))
            
            Image(systemName: configuration.isOn ? "moon.fill" : "sun.max.fill")
                .foregroundColor(configuration.isOn ? Color("Yellow") : Color("Gray"))
                .frame(width: 25)
                .offset(y: configuration.isOn ? 14 : -14)
            
        }.frame(width:25 , height: 50)
            .gesture(DragGesture().onEnded({ _ in
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }))
            .onTapGesture {
                withAnimation(.spring()) {
                    configuration.isOn.toggle()
                }
            }
    }
}
