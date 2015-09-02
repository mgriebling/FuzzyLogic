//
//  FuzzySet.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

public struct FuzzySet : Comparable, CustomStringConvertible {
    
    private var data: [Fuzzy]

    public init(size: Int = 1) { // constructor
        let dimension = size >= 0 ? size : 1
        data = [Fuzzy](count: dimension, repeatedValue: Fuzzy(0.0))
    }

    public init(set: FuzzySet) {
        data = set.data
    }
    
    public subscript (index: Int) -> Fuzzy {
        get { return index >= 0 && index < data.count ? data[index] : data[0] }
        set { if index >= 0 && index < data.count { data[index] = newValue } }
    }
    
    public var count : Int { return data.count }
    
    public var description: String {
        var s = "("
        for ctr in 0..<data.count-1 {
            s += "\(data[ctr]) "
        }
        return s + "\(data.last!))"
    }

    public static func max(set: FuzzySet) -> Fuzzy {
        var tmp_fuzzy = Fuzzy(0.0)
        
        for i in 0..<set.data.count {
            tmp_fuzzy |= set[i]
        }
        return tmp_fuzzy
    }
}

public func < (lhs : FuzzySet, rhs: FuzzySet) -> Bool {
    if lhs.data.count == rhs.data.count {
        for ctr in 0..<lhs.data.count {
            if lhs[ctr] >= rhs[ctr] { return false }
        }
        return true
    }
    return false
}

public func == (lhs : FuzzySet, rhs: FuzzySet) -> Bool {
    if lhs.data.count == rhs.data.count {
        for ctr in 0..<lhs.data.count {
            if lhs[ctr] != rhs[ctr] { return false }
        }
        return true
    }
    return false
}
