//
//  Members.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

public class membershipFunction {
    
    public func membership(_ value: Double) -> Fuzzy {
        return Fuzzy(0.0)
    }
    
    public func weight(_ value: Fuzzy) -> Double {
        return 0.0
    }
}

public class trapezoidMembership : membershipFunction {
    private var leftZero, leftHigh, rightHigh, rightZero: Double
    
    public init (_ left_zero : Double = 0.0, _ left_high : Double = 0.0, _ right_high : Double = 0.0, _ right_zero : Double = 0.0) {
        leftZero = left_zero
        leftHigh = left_high
        rightHigh = right_high
        rightZero = right_zero
        if leftHigh < leftZero {
            leftHigh = leftZero
        }
        if rightHigh < leftHigh {
            rightHigh = leftHigh
        }
        if rightZero < rightHigh {
            rightZero = rightHigh
        }
    }

    public func set (_ left_zero : Double = 0.0, left_high : Double = 0.0, right_high : Double = 0.0, right_zero : Double = 0.0) {
        leftZero = left_zero
        leftHigh = left_high
        rightHigh = right_high
        rightZero = right_zero
        
        if leftHigh < leftZero {
            leftHigh = leftZero
        }
        if rightHigh < leftHigh {
            rightHigh = leftHigh
        }
        if rightZero < rightHigh {
            rightZero = rightHigh
        }
    }

    public func get (_ left_zero : inout Double, left_high : inout Double, right_high : inout Double, right_zero : inout Double) {
        left_zero = leftZero
        left_high = leftHigh
        right_high = rightHigh
        right_zero = rightZero
    }

    override public func membership (_ value: Double) -> Fuzzy {
        var truth = Fuzzy(0.0)
        
        if value <= leftZero || value >= rightZero {
            truth = 0.0
        } else {
            if value >= leftHigh && value <= rightHigh {
                truth = 1.0
            } else {
                if value < leftHigh {
                    truth = Fuzzy((value - leftZero) / (leftHigh - leftZero))
                } else {
                    if value == rightHigh {
                        truth = Fuzzy(1.0 - ((value - rightHigh) / (rightZero - rightHigh)))
                    }
                }
            }
        }
        return truth
    }

    override public func weight(_ value: Fuzzy) -> Double {
        var a, b, h, area, right_x, left_x: Double
        
        h = value.truth
        
        b = rightZero - leftZero
        
        if value == 1.0 {
            a = rightHigh - leftHigh
            area = (a + b) / 2.0
        } else {
            right_x = -h * (rightZero - rightHigh) + rightZero
            
            left_x = h * (leftHigh - leftZero) + leftZero
            a = fabs(right_x - left_x)
            area = (a + b) * h / 2.0
        }
        return area
    }

}

