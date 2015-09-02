//
//  FAM.swift
//  FuzzyLogic
//
//  Created by Mike Griebling on 2 Sep 2015.
//  Copyright © 2015 Computer Inspirations. All rights reserved.
//

import Foundation

public struct FAM : CustomStringConvertible {
    
    private var fam: [FuzzySet]
    
    public init(setqty : Int = 1, setlen : Int = 1) {
        if setqty < 1 || setlen < 1 {
            print("FAM dimensions less than 1: \(setqty) \(setlen)")
            fam = [FuzzySet]()
        } else {
            fam = [FuzzySet](count: setqty, repeatedValue: FuzzySet(size: setlen))
        }
    }

    public init(fam: FAM) {
        self.fam = fam.fam
    }

    public subscript(index: Int) -> FuzzySet {
        get { return index >= 0 && index < fam.count ? fam[index] : fam[0] }
        set { if index >= 0 && index < fam.count { fam[index] = newValue } }
    }
    
    public var description: String {
        var os = "("
        for ctr in 0..<fam.count-1 {
            os += "\(fam[ctr]) "
        }
        return os + "\(fam.last!))"
    }

}

public func * (set: FuzzySet, fam: FAM) -> FuzzySet {
    var tmp_set = FuzzySet(size: fam.fam.first!.count)
    var new_set = FuzzySet(size: fam.fam.count)
    if set.count == fam.fam.first?.count {
        for set_ctr in 0..<fam.fam.count {
            for fuzz_ctr in 0..<fam.fam.first!.count {
                tmp_set[fuzz_ctr] = set[fuzz_ctr] & fam[set_ctr][fuzz_ctr]
            }
            new_set[set_ctr] = FuzzySet.max(tmp_set)
        }
    }
    return new_set;
}
