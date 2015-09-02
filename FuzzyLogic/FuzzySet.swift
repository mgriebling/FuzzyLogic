//
//  FuzzySet.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

public struct FuzzySet : Comparable {
    
    private var dimension: Int
    private var data: [Fuzzy]

    public init(size: Int = 1) { // constructor
        dimension = size >= 0 ? size : 1
        data = [Fuzzy](count: dimension, repeatedValue: 0.0)
    }

    public init(set: FuzzySet) {
        dimension = set.dimension
        data = set.data
    }
    
    public subscript (index: Int) -> Fuzzy {
        return index >= 0 && index < dimension ? data[index] : data[0]
    }

//ostream& operator<<(ostream& s, fzy_set& z)
//{
//    static int ctr;
//    s << "(";
//    fuzzy *set = z.fzy_data;
//    int ind = z.dimension - 1;
//    for (ctr = 0; ctr < ind; ctr++)
//    {
//        s << *set++ << " ";
//    }
//    return s << *set << ")\n";
//}
//
//fuzzy fzy_set_max(const fzy_set& set)
//{
//    auto fuzzy tmp_fuzzy(0.0);
//    
//    for (int i = 0; i < set.dimension; i++)
//    {
//        tmp_fuzzy |= set[i];
//    }
//    return tmp_fuzzy;
//}

}

public func < (lhs : FuzzySet, rhs: FuzzySet) -> Bool {
    if lhs.dimension == rhs.dimension {
        for ctr in 0..<lhs.dimension {
            if lhs[ctr] >= rhs[ctr] { return false }
        }
        return true
    }
    return false
}

public func == (lhs : FuzzySet, rhs: FuzzySet) -> Bool {
    if lhs.dimension == rhs.dimension {
        for ctr in 0..<lhs.dimension {
            if lhs[ctr] != rhs[ctr] { return false }
        }
        return true
    }
    return false
}
