import UIKit
import Charts

class LineView: LineChartView {
    
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var unitsSold = [1.25,   2.11,    3.08,    4.38,    5.65,    5.85,    6.04,    5.33,    3.93,    2.52,    1.36,    1.04]
    var x2: [Double] = [1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000,1000]
    var limit = 0.0
    
    var batteryCount = 5.0
    var batteryCapacityW = 250.0
    
    var axisFormatDelegate: IAxisValueFormatter?
    
    init(batteriesData: [Double], limit: Double) {
        super.init(frame: .zero)
        configure()
        self.unitsSold = batteriesData
        for i in 0...11 {
            x2[i] = (limit)
        }
        self.limit = limit
        setUpBarChart()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setUpBarChart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .systemGray6
    }
    
    func setUpBarChart() {
        axisFormatDelegate = self
        setChart(dataPoints: months, x1: unitsSold)
        legend.enabled = false
        xAxis.labelPosition = .bottom
        xAxis.drawGridLinesEnabled = false
        leftAxis.drawGridLinesEnabled = false
        //        rightAxis.drawGridLinesEnabled = true
        rightAxis.enabled = false
        
        //        pinchZoomEnabled = false
    }
    
    func setChart(dataPoints: [String], x1: [Double]) {
    
        let lineData = LineChartData()
        var lineChartEntry1 = [ChartDataEntry]()
        
        for i in 0..<x1.count {
            lineChartEntry1.append(ChartDataEntry(x: Double(i), y: Double(x1[i]) ))
        }
        let line1 = LineChartDataSet(entries: lineChartEntry1, label: "First Dataset")
        line1.colors = [.lightGreen()]
        line1.circleColors = [.lightGreen()]
        line1.circleHoleColor = .systemGray6
        lineData.addDataSet(line1)
        if (x2.count > 0) {
            var lineChartEntry2 = [ChartDataEntry]()
            for i in 0..<x2.count {
                lineChartEntry2.append(ChartDataEntry(x: Double(i), y: Double(x2[i]) ))
            }
            let line2 = LineChartDataSet(entries: lineChartEntry2, label: "Second Dataset")
            line2.drawValuesEnabled = false
            line2.circleHoleRadius = 0.1
            line2.circleRadius = 0.2
            line2.circleColors = [.red]
            line2.colors = [.systemRed]
            line2.label = "\(limit)"
            lineData.addDataSet(line2)
        }
        data = lineData
        let xAxisValue = xAxis
        xAxisValue.valueFormatter = axisFormatDelegate
        xAxisValue.setLabelCount(dataPoints.count, force: true)
    }
}


extension LineView: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return months[Int(value)]
    }
}
