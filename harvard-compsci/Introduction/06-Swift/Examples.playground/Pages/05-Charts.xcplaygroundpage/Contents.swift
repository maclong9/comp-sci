/*:
 # Swift Charts
 
 One of the more convenient libraries is Swift Charts, this library allows you to display charts of varying kinds within your program or playground, this can be particularly useful for scientific or mathematical computing as you can create documentation and notes with functioning code that can have the variables altered inline with your notes so you can see the changes.
 */
import SwiftUI
import Charts
import PlaygroundSupport

struct DataPoint: Identifiable {
  var id = UUID()
  var category: String
  var value: Double
}

let sampleData: [DataPoint] = [
  DataPoint(category: "A", value: 5),
  DataPoint(category: "B", value: 3),
  DataPoint(category: "C", value: 8),
  DataPoint(category: "D", value: 2)
]

let lineChartData: [DataPoint] = [
  DataPoint(category: "Jan", value: 2),
  DataPoint(category: "Feb", value: 4),
  DataPoint(category: "Mar", value: 1),
  DataPoint(category: "Apr", value: 5),
  DataPoint(category: "May", value: 3)
]

func calculateTrajectory(angle: Double, velocity: Double, steps: Int = 100) -> [DataPoint] {
  let g = 9.8  // Acceleration due to gravity (m/s^2)
  let radianAngle = angle * .pi / 180
  let vx = velocity * cos(radianAngle)
  let vy = velocity * sin(radianAngle)
  
  var trajectoryData: [DataPoint] = []
  
  for step in 0...steps {
    let t = Double(step) * 0.1
    let x = vx * t
    let y = vy * t - 0.5 * g * t * t
    
    if y < 0 { break }
    
    trajectoryData.append(DataPoint(category: String(format: "%.1f", x), value: y))
  }
  
  return trajectoryData
}

struct BarChartView: View {
  var data: [DataPoint]
  
  var body: some View {
    Chart(data) { point in
      BarMark(
        x: .value("Category", point.category),
        y: .value("Value", point.value)
      )
    }
    .chartXAxisLabel("Category")
    .chartYAxisLabel("Value")
    .padding()
  }
}

struct LineChartView: View {
  var data: [DataPoint]
  
  var body: some View {
    Chart(data) { point in
      LineMark(
        x: .value("Month", point.category),
        y: .value("Value", point.value)
      )
    }
    .chartXAxisLabel("Month")
    .chartYAxisLabel("Value")
    .padding()
  }
}

struct TrajectoryChartView: View {
  var angle: Double
  var velocity: Double
  
  var body: some View {
    let trajectoryData = calculateTrajectory(angle: angle, velocity: velocity)
    
    return Chart(trajectoryData) { point in
      LineMark(
        x: .value("Distance", Double(point.category)!),
        y: .value("Height", point.value)
      )
    }
    .chartXAxisLabel("Distance (m)")
    .chartYAxisLabel("Height (m)")
    .padding()
  }
}

struct ContentView: View {
  var body: some View {
    VStack {
      BarChartView(data: sampleData)
        .frame(height: 200)
      
      LineChartView(data: lineChartData)
        .frame(height: 200)
      
      TrajectoryChartView(angle: 42, velocity: 52)
        .frame(height: 200)
    }
    .frame(width: 400)
  }
}

// Set the playground live view to ContentView
PlaygroundPage.current.setLiveView(ContentView())

//: [Previous](@previous)     [Next](@next)
