//
//  BarChartView.swift
//  TheWeatherApp
//
//  Created by Vitaly Chernysh on 08.07.2018.
//  Copyright © 2018 Vitaly Chernysh. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class BarChartView: UIView {

    var didSelectChartIndex: Observable<Int> {
        return chartIndexPublishSubject.asObservable()
    }

    private var chartIndexPublishSubject = PublishSubject<Int>()

    private let mainLayer: CALayer = CALayer()
    private let scrollView: UIScrollView = UIScrollView()

    private let barWidth: CGFloat = 65.0
    private let spacing: CGFloat = 10.0
    private let bottomSpaceToScrollView: CGFloat = 40.0
    private let topSpaceToScrollView: CGFloat = 20.0
    private var barLayers = [CALayer]()

    var charts: [ChartData]! {
        didSet {
            mainLayer.sublayers?.forEach({ $0.removeFromSuperlayer() })
            barLayers.removeAll()
            
            if let charts = charts {
                scrollView.contentSize = CGSize(width: (barWidth + spacing) * CGFloat(charts.count), height: frame.size.height)
                mainLayer.frame = CGRect(x: 0.0, y: 0.0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
                
                for index in 0..<charts.count {
                    draw(chartAtIndex: index)
                }
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    override func layoutSubviews() {
        scrollView.frame = CGRect(x: 0.0, y: 0.0, width: frame.size.width, height: frame.size.height)
    }

    private func setupView() {
        scrollView.layer.addSublayer(mainLayer)
        addSubview(scrollView)

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(touchReceived(_:)))
        scrollView.addGestureRecognizer(tapGestureRecognizer)
        scrollView.contentInset.right = 15.0
        scrollView.contentInset.left = 15.0
    }

    @objc func touchReceived(_ sender: UITapGestureRecognizer) {
        let tapLocation = sender.location(in: scrollView)
        barLayers.forEach {
            if $0.frame.contains(tapLocation) {
                if let chartIndex = barLayers.index(of: $0) {
                    chartIndexPublishSubject.onNext(chartIndex)
                }
                return
            }
        }
    }

    private func verticalPosition(fromHeight height: Float) -> CGFloat {
        let height = CGFloat(height) * (mainLayer.frame.height - bottomSpaceToScrollView - topSpaceToScrollView)
        return mainLayer.frame.height - bottomSpaceToScrollView - height
    }

    private func draw(chartAtIndex index: Int) {
        let currentChart = charts[index]

        let horizontalPosition = CGFloat(index) * (barWidth + spacing)
        let verticalPosition = self.verticalPosition(fromHeight: currentChart.height / 30.0)

        drawBar(horizontalPosition: horizontalPosition, verticalPosition: verticalPosition, color: currentChart.color)
        drawTitle(horizontalPosition: horizontalPosition - spacing / 2, verticalPosition: verticalPosition - 30.0, textValue: currentChart.topTitle + "°C", color: currentChart.color, fontSize: 15.0)
        drawTitle(horizontalPosition: horizontalPosition - spacing / 2, verticalPosition: mainLayer.frame.height -
            bottomSpaceToScrollView + 10.0, textValue: currentChart.bottomTitle, color: currentChart.color, fontSize: 10.0)
    }

    private func drawBar(horizontalPosition: CGFloat, verticalPosition: CGFloat, color: UIColor) {
        let barLayer = CALayer()
        barLayer.frame = CGRect(x: horizontalPosition, y: verticalPosition, width: barWidth,
                                height: mainLayer.frame.height - bottomSpaceToScrollView - verticalPosition)
        barLayer.backgroundColor = color.cgColor
        barLayers.append(barLayer)
        mainLayer.addSublayer(barLayer)
    }

    private func drawTitle(horizontalPosition: CGFloat, verticalPosition: CGFloat, textValue: String, color: UIColor, fontSize: CGFloat) {
        let textLayer = CATextLayer()
        textLayer.frame = CGRect(x: horizontalPosition, y: verticalPosition, width: barWidth + spacing, height: 22.0)
        textLayer.foregroundColor = color.cgColor
        textLayer.alignmentMode = kCAAlignmentCenter
        textLayer.contentsScale = UIScreen.main.scale
        textLayer.fontSize = fontSize
        textLayer.string = textValue
        mainLayer.addSublayer(textLayer)
    }

}
