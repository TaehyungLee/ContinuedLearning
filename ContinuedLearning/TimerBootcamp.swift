//
//  TimerBootcamp.swift
//  ContinuedLearning
//
//  Created by Taehyung Lee on 2022/10/25.
//

import SwiftUI


// 1초마다 함수를 호출할 경우 매우 유용하다
struct TimerBootcamp: View {
    
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    
    // current time
    /*
    @State var currentDate = Date()
    var dateFormatter:DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    // countdown
    /*
    @State var count = 10
    @State var finishedText:String? = nil
    */
    
    // countdown to date
    /*
    @State var timeRemaining:String = ""
    let futureDate = Calendar.current.date(byAdding: .day, value: 1, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour):\(minute):\(second)"
    }
     */
    
    // Animation Counter
    @State var count:Int = 0
    
    var body: some View {
        ZStack {
            RadialGradient(gradient: Gradient(colors: [Color.blue, Color.purple]),
                           center: .center,
                           startRadius: 5,
                           endRadius: 500)
            .ignoresSafeArea()
//            Text(dateFormatter.string(from: currentDate))
//            Text(finishedText ?? "\(count)")
//            Text(timeRemaining)
//                .font(Font.system(size: 100, weight: .semibold, design: .rounded))
//                .foregroundColor(.white)
//                .lineLimit(1)
//                .minimumScaleFactor(0.1)
            
//            HStack(spacing:15) {
//                Circle()
//                    .offset(y: count == 1 ? -20:0)
//                Circle()
//                    .offset(y: count == 2 ? -20:0)
//                Circle()
//                    .offset(y: count == 3 ? -20:0)
//            }
//            .frame(width: 200)
//            .foregroundColor(.white)
            
            TabView (selection: $count) {
                Rectangle()
                    .foregroundColor(.red)
                    .tag(1)
                Rectangle()
                    .foregroundColor(.blue)
                    .tag(2)
                Rectangle()
                    .foregroundColor(.green)
                    .tag(3)
                Rectangle()
                    .foregroundColor(.orange)
                    .tag(4)
                Rectangle()
                    .foregroundColor(.pink)
                    .tag(5)
            }
            .frame(height:200)
            .tabViewStyle(.page)
            
        }
        .onReceive(timer) { value in
            // 매 시간마다 작업
//            currentDate = value
//            if count < 1 {
//                finishedText = "Wow!"
//            }else {
//                count -= 1
//            }
//            updateTimeRemaining()
            withAnimation(.easeInOut(duration: 0.5)) {
                count = count == 5 ? 0 : count + 1
            }
            
            
        }
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
