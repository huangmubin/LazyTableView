//
//  TestView.swift
//  LazyTableView
//
//  Created by Myron on 2017/6/20.
//  Copyright © 2017年 Myron. All rights reserved.
//

import UIKit

class TestView: UIView {

    // MARK: - Init
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        deploy()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    
    var layer_top: CAShapeLayer = CAShapeLayer()
    var layer_center: CAShapeLayer = CAShapeLayer()
    var layer_bottom: CAShapeLayer = CAShapeLayer()
    
    
    override var frame: CGRect {
        didSet {
            deploy()
        }
    }
    
    override var bounds: CGRect {
        didSet {
            deploy()
        }
    }
    
    private func deploy() {
//        layer_top.removeFromSuperlayer()
//        layer_center.removeFromSuperlayer()
//        layer_bottom.removeFromSuperlayer()
//        let color = UIColor.red.cgColor
//        let corner: CGFloat = 30
//        if let corner = tableview?.section_corner {
//            if corner != 0 {
//                let x_l: CGFloat = 0
//                let x_c: CGFloat = bounds.width / 2
//                let x_r: CGFloat = bounds.width
//                let y_t: CGFloat = 0
//                let y_b: CGFloat = bounds.height
//                let x_p1: CGFloat = corner
//                let x_p2: CGFloat = bounds.width - corner
//                let y_p1: CGFloat = corner
//                let y_p2: CGFloat = bounds.height - corner
//                
//                let _ = {
//                    let path = UIBezierPath()
//                    path.move(to: CGPoint(x: x_c, y: y_t))
//                    path.addLine(to: CGPoint(x: x_l, y: y_t))
//                    path.addLine(to: CGPoint(x: x_l, y: y_b))
//                    path.addLine(to: CGPoint(x: x_r, y: y_b))
//                    path.addLine(to: CGPoint(x: x_r, y: y_t))
//                    path.addLine(to: CGPoint(x: x_c, y: y_t))
//                    
//                    path.addLine(to: CGPoint(x: x_p2, y: y_t))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p2, y: y_p1),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 1.5,
//                        endAngle: CGFloat.pi * 0,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_r, y: y_b))
//                    path.addLine(to: CGPoint(x: x_l, y: y_b))
//                    path.addLine(to: CGPoint(x: x_l, y: y_p1))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p1, y: y_p1),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 1,
//                        endAngle: CGFloat.pi * 1.5,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_c, y: y_t))
//                    
//                    layer_top.path = path.cgPath
//                    layer_top.fillColor = color
//                    layer.addSublayer(layer_top)
//                }()
//                let _ = {
//                    let path = UIBezierPath()
//                    path.move(to: CGPoint(x: x_c, y: y_t))
//                    path.addLine(to: CGPoint(x: x_l, y: y_t))
//                    path.addLine(to: CGPoint(x: x_l, y: y_b))
//                    path.addLine(to: CGPoint(x: x_r, y: y_b))
//                    path.addLine(to: CGPoint(x: x_r, y: y_t))
//                    path.addLine(to: CGPoint(x: x_c, y: y_t))
//                    
//                    path.addLine(to: CGPoint(x: x_p2, y: y_t))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p2, y: y_p1),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 1.5,
//                        endAngle: CGFloat.pi * 0,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_r, y: y_p2))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p2, y: y_p2),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 0,
//                        endAngle: CGFloat.pi * 0.5,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_p1, y: y_b))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p1, y: y_p2),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 0.5,
//                        endAngle: CGFloat.pi * 1,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_l, y: y_p1))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p1, y: y_p1),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 1,
//                        endAngle: CGFloat.pi * 1.5,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_c, y: y_t))
//                    
//                    layer_center.path = path.cgPath
//                    layer_center.fillColor = color
//                    layer.addSublayer(layer_center)
//                }()
//                let _ = {
//                    let path = UIBezierPath()
//                    path.move(to: CGPoint(x: x_c, y: y_t))
//                    path.addLine(to: CGPoint(x: x_l, y: y_t))
//                    path.addLine(to: CGPoint(x: x_l, y: y_b))
//                    path.addLine(to: CGPoint(x: x_r, y: y_b))
//                    path.addLine(to: CGPoint(x: x_r, y: y_t))
//                    path.addLine(to: CGPoint(x: x_c, y: y_t))
//                    
//                    path.addLine(to: CGPoint(x: x_r, y: y_t))
//                    path.addLine(to: CGPoint(x: x_r, y: y_p2))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p2, y: y_p2),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 0,
//                        endAngle: CGFloat.pi * 0.5,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_p1, y: y_b))
//                    path.addArc(
//                        withCenter: CGPoint(x: x_p1, y: y_p2),
//                        radius: corner,
//                        startAngle: CGFloat.pi * 0.5,
//                        endAngle: CGFloat.pi * 1,
//                        clockwise: true
//                    )
//                    path.addLine(to: CGPoint(x: x_l, y: y_t))
//                    path.addLine(to: CGPoint(x: x_c, y: y_t))
//                    
//                    layer_bottom.path = path.cgPath
//                    layer_bottom.fillColor = color
//                    layer.addSublayer(layer_bottom)
//                }()
//            }
//        }

    }

}
