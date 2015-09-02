//
//  Fuzzy.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

public struct Fuzzy : FloatLiteralConvertible, Comparable, CustomStringConvertible {
    
    private var _truth: Double
    public var truth: Double {
        get { return _truth }
        set { _truth = newValue >= 0.0 && newValue <= 1.0 ? newValue : 0.0 }
    }
    
    public var description: String { return "\(truth)" }
    
    public init(_ truth: Double = 0.0) {
        _truth = 0
        self.truth = truth
    }
    
    public init(floatLiteral: Double) { self.init(floatLiteral) }
    
    public func very() -> Fuzzy {
        return Fuzzy(truth * truth)
    }
    
    public func somewhat() -> Fuzzy {
        return Fuzzy(sqrt(truth))
    }
    
    public static func implies(value_a: Fuzzy, value_b: Fuzzy) -> Fuzzy {
        let temp_value: Double
        temp_value = 1.0 - value_a.truth + value_b.truth
        return Fuzzy(temp_value < 1.0 ? temp_value : 1.0)
    }
    
    public static func iff(value_a: Fuzzy, value_b: Fuzzy) -> Fuzzy {
        return Fuzzy(1.0 - fabs(value_a.truth - value_b.truth))
    }
    
    //istream& operator>>(istream& s, Fuzzy& fur)
    //{
    //    auto double lint = 0.0;
    //
    //    s >> lint;
    //    fur = lint;
    //    
    //    return s;
    //}
    
}

public prefix func ! (a: Fuzzy) -> Fuzzy {
    return Fuzzy(1.0 - a.truth)
}

public func | (lhs : Fuzzy, rhs: Fuzzy) -> Fuzzy {
    return lhs.truth > rhs.truth ? lhs : rhs
}

public func & (lhs : Fuzzy, rhs: Fuzzy) -> Fuzzy {
    return lhs.truth < rhs.truth ? lhs : rhs
}

public func |= (inout value: Fuzzy, b: Fuzzy) {
    value = value | b
}

public func &= (inout value: Fuzzy, b: Fuzzy) {
    value = value & b
}

//
// For Comparable compliance -- <=, >, >=, != are free
public func < (lhs : Fuzzy, rhs: Fuzzy) -> Bool {
    return lhs.truth < rhs.truth
}

public func == (lhs : Fuzzy, rhs: Fuzzy) -> Bool {
    return lhs.truth == rhs.truth
}

