//
//  ClockFaceView.swift
//  ClockFaceViewDemo
//
//  Created by 王 巍 on 14/10/23.
//  Copyright (c) 2014年 OneV's Den. All rights reserved.
//

import UIKit

@IBDesignable
class ClockFaceView : UIView {

    class ClockFaceLayer : CAShapeLayer {
        
        private let hourHand: CAShapeLayer
        private let minuteHand: CAShapeLayer
        
        override init() {
            hourHand = CAShapeLayer()
            minuteHand = CAShapeLayer()
            
            super.init()
            frame = CGRect(x: 0, y: 0, width: 200, height: 200)
            path = UIBezierPath(ovalInRect: CGRectInset(frame, 5, 5)).CGPath
            fillColor = UIColor.whiteColor().CGColor
            strokeColor = UIColor.blackColor().CGColor
            lineWidth = 4
            
            hourHand.path = UIBezierPath(rect: CGRect(x: -2, y: -70, width: 4, height: 70)).CGPath
            hourHand.fillColor = UIColor.blackColor().CGColor
            hourHand.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
            addSublayer(hourHand)
            
            minuteHand.path = UIBezierPath(rect: CGRect(x: -1, y: -90, width: 2, height: 90)).CGPath
            minuteHand.fillColor = UIColor.blackColor().CGColor
            minuteHand.position = CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
            addSublayer(minuteHand)
        }
        
        required init(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func refreshToHour(hour: Int, minute: Int) {
            hourHand.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(hour) / 12.0 * 2.0 * M_PI)))
            minuteHand.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(Double(minute) / 60.0 * 2.0 * M_PI)))
        }
        
        func refreshColor(color: UIColor) {
            hourHand.fillColor = color.CGColor
            minuteHand.fillColor = color.CGColor
            strokeColor = color.CGColor
        }
        
    }
    
    private let clockFace: ClockFaceLayer
    
    var time: NSDate? {
        didSet {
            refreshTime()
        }
    }
    
    private func refreshTime() {
        if let realTime = time {
            if let calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar) {
                let components = calendar.components(NSCalendarUnit.CalendarUnitHour |
                                                     NSCalendarUnit.CalendarUnitMinute, fromDate: realTime)
                clockFace.refreshToHour(components.hour, minute: components.minute)
            }
        }
    }
    
    override init(frame: CGRect) {
        clockFace = ClockFaceLayer()
        super.init(frame: frame)
        layer.addSublayer(clockFace)
    }
    
    required init(coder aDecoder: NSCoder) {
        clockFace = ClockFaceLayer()
        super.init(coder: aDecoder)
        layer.addSublayer(clockFace)
    }
    
    override func prepareForInterfaceBuilder() {
        time = NSDate()
    }
    
    @IBInspectable
    var color: UIColor? {
        didSet {
            refreshColor()
        }
    }
    
    private func refreshColor() {
        if let realColor = color {
            clockFace.refreshColor(realColor)
        }
    }
}