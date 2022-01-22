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
    
    var buttonColor : Color {
        switch self {
        case .clear , .equal , .divide , .mutliply , .subtract , .add :
            return Color("Yellow")
        default:
            return Color("ButtonColor")
        }
    }
    
    var BackGroundColor: Color {
        switch self {
        case .add, .subtract, .mutliply, .divide, .equal:
            return Color("BGButtonColor")
        default:
            return Color.clear
        }
    }
}

enum Operation {
    case add, subtract, multiply, divide, none
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
    @State var value = "0"
    @State var value1 = "0"
    @State var Numbers = ""
    @State var runningNumber = 0.0
    @State var currentOperation: Operation = .none
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
                Text(value1)
                    .font(.system(size:100))
                    .fontWeight(.medium)
                    .foregroundColor(Color("Yellow"))
                    .frame(maxWidth:.infinity , alignment:.trailing)
                    .padding(.horizontal)
                if Numbers != "" {
                    Text(Numbers)
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundColor(Color("Yellow"))
                        .frame(maxWidth:.infinity , alignment:.trailing)
                        .padding(.horizontal)
                }
                Spacer()
                ForEach(self.buttons , id: \.self) { row in
                    HStack{
                        ForEach(row , id: \.self) { button in
                            Button(action:{
                                withAnimation(.spring()) {
                                    self.didTap(button: button)
                                }
                            }) {
                                Text(button.rawValue)
                                    .font(.largeTitle)
                                    .fontWeight(.medium)
                                    .frame(width: self.buttonWidth(item: button),
                                           height: self.buttonHeight())
                                    .background(button.BackGroundColor.opacity(0.1))
                                    .foregroundColor(button.buttonColor)
                                    .cornerRadius(self.buttonWidth(item: button)/2)
                            }
                        }
                    }
                }
            }
        }.preferredColorScheme(ToggleBool ? .dark : .light)
    }
    func didTap(button: CalcButton) {
        
        switch button {
            
        case .add, .subtract, .mutliply, .divide, .equal :
            if button == .add {
                self.Numbers += (" \(button.rawValue.description) ")
                self.currentOperation = .add
                self.runningNumber = Double(self.value) ?? 0.0
            } else if button == .subtract {
                self.Numbers += (" \(button.rawValue.description) ")
                self.currentOperation = .subtract
                self.runningNumber = Double(self.value) ?? 0.0
            } else if button == .mutliply {
                self.Numbers += (" \(button.rawValue.description) ")
                self.currentOperation = .multiply
                self.runningNumber = Double(self.value) ?? 0.0
            } else if button == .divide {
                self.Numbers += (" \(button.rawValue.description) ")
                self.currentOperation = .divide
                self.runningNumber = Double(self.value) ?? 0.0
            } else if button == .equal {
                
                let runningValue = self.runningNumber
                let currentValue = Double(self.value) ?? 0.0
                switch self.currentOperation {
                case .add: self.value1 = "\(runningValue + currentValue)"
                case .subtract: self.value1 = "\(runningValue - currentValue)"
                case .multiply: self.value1 = "\(runningValue * currentValue)"
                case .divide: self.value1 = "\(runningValue / currentValue)"
                case  .none :
                    break
                }
            }
            
            if button != .equal {
                self.value = "0"
                
            }
        case .clear:
            self.value = "0"
            self.value1 = "0"
            self.Numbers = ""
        case .decimal :
            self.value += "."
            self.Numbers += "."
        case .negative , .percent :
            break
        default:
            let number = button.rawValue
            if self.value == "0" {
                value = number
                
            } else {
                self.value = "\(self.value)\(number)"
            }
            if self.value == "0" {
                self.Numbers = ""
            }
            if self.Numbers != "" {
                self.Numbers += "\(number)"
            } else {
                self.Numbers = value
            }
        }
    }
    
    func buttonWidth(item: CalcButton) -> CGFloat {
        if item == .equal {
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    
    func buttonHeight() -> CGFloat {
        return (UIScreen.main.bounds.width - (5*12)) / 4
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
