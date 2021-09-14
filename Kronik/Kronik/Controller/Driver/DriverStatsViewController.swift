//
//  DriverStatsViewController.swift
//  Kronik
//
//  Created by Kunle Ademefun on 6/12/21.
//

import UIKit
import Charts
class DriverStatsViewController: UIViewController {
    @IBOutlet weak var menuBarButton: UIBarButtonItem!
    @IBOutlet weak var chartView: BarChartView!
    
    var weekdays = ["Mon", "Tue" , "Wed", "Thu", "Fri","Sat", "Sun"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        menuBarButton.target = self.revealViewController()
        menuBarButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        
        //#1 - Initialize Chart
//        self.initChart()
        
        //#2 - Load CHart Data/
//        self.loadChartData()
        
    }
    
    func initChart(){
//        chartView.noDataText = "No Data"
//        chartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0, easingOption: .easeInBounce)
//        chartView.xAxis.labelPosition = .bottom
//        chartView.descriptionText = ""
//        chartView.xAxis.setLabelsToSkip(0)
//
//        chartView.legend.enabled = false
//        chartView.scaleYEnabled = false
//        chartView.scaleXEnabled = false
//        chartView.pinchZoomEnabled = false
//        chartView.doubleTapToZoomEnabled = false
//
//        chartView.leftAxis.axisMinValue = 0.0
//        chartView.leftAxis.axisMaxValue = 100.00
//        chartView.highlighter = nil
//        chartView.rightAxis.enabled = false
//        chartView.xAxis.drawGridLinesEnabled = false
    }
    
    func loadChartData(){
        APIManager.shared.getDriverRevenue { (json) in
//            
//            if json != nil {
//                
//                let revenue = json["revenue"]
//                
//                var dataEntries: [BarChartDataEntry] = []
//                
//                for i in 0..<self.weekdays.count {
//                    let day = self.weekdays[i]
//                    let dataEntry = BarChartDataEntry(value: revenue[day].double!, xIndex: i)
//                    dataEntries.append(dataEntry)
//                }
//                
//                let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Revenue by day")
//                chartDataSet.colors = ChartColorTemplates.material()
//                
//                let chartData = BarChartData(xVals: self.weekdays, dataSet: chartDataSet)
//                
//                self.chartView.data = chartData
//                
//            }
        }
    }
}
