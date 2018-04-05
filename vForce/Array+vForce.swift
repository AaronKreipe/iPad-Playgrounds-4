// vForce+Array.swift
// 2018 @AaronKreipe

import Foundation
import Accelerate

extension Array where Element: FloatingPoint{
    func perform(vvop:
        (UnsafeMutablePointer<Element>,
        UnsafePointer<Element>,
        UnsafePointer<Int32>)->()
        )->[Element]{
        var y = [Element](repeating: 0, count: count)
        var n = Int32(count)
        vvop(&y, self, &n)
        return y
    }
    func perform(with x: inout [Element], vvop:
        (UnsafeMutablePointer<Element>,
        UnsafePointer<Element>,
        UnsafePointer<Element>,
        UnsafePointer<Int32>)->()
        )->[Element]{
        var z = [Element](repeating: 0, count: count)
        var n = Int32(count)
        vvop(&z, self, &x, &n)
        return z
    }
}

extension Array where Element == Double{
    public var roundedUp: Array{return perform(vvop: vvceil)}
    public var roundedDown: Array{return perform(vvop: vvfloor)}
    public var absoluteValues: Array{return perform(vvop: vvfabs)}
    public var truncatedIntegerValues: Array{return perform(vvop: vvint)}
    public var nearestIntegerValues: Array{return perform(vvop: vvnint)}
    public var squareRoots: Array{return perform(vvop: vvsqrt)}
    public var reciprocalSquareRoots: Array{return perform(vvop: vvrsqrt)}
    public var reciprocals: Array{return perform(vvop: vvrec)}
    public func copyingSigns(from: [Element])->[Element]{
        var x = from
        return perform(with: &x, vvop: vvcopysign)
    }
    public func dividing(by: [Element])->[Element]{
        var x = by
        return perform(with: &x, vvop: vvdiv)
    }
    public func moduli(dividingBy: [Element])->[Element]{
        var x = dividingBy
        return perform(with: &x, vvop: vvfmod)
    }
    public func remainders(dividingBy: [Element])->[Element]{
        var x = dividingBy
        return perform(with: &x, vvop: vvremainder)
    }
    public func nextAfter(inDirections: [Element])->[Element]{
        var x = inDirections
        return perform(with: &x, vvop: vvnextafter)
    }
}

extension Array where Element == Float{
    public var roundedUp: Array{return perform(vvop: vvceilf)}
    public var roundedDown: Array{return perform(vvop: vvfloorf)}
    public var absoluteValues: Array{return perform(vvop: vvfabsf)}
    public var truncatedIntegerValues: Array{return perform(vvop: vvintf)}
    public var nearestIntegerValues: Array{return perform(vvop: vvnintf)}
    public var squareRoots: Array{return perform(vvop: vvsqrtf)}
    public var reciprocalSquareRoots: Array{return perform(vvop: vvrsqrtf)}
    public var reciprocals: Array{return perform(vvop: vvrecf)}
    public func copyingSigns(from: [Element])->[Element]{
        var x = from
        return perform(with: &x, vvop: vvcopysignf)
    }
    public func dividing(by: [Element])->[Element]{
        var x = by
        return perform(with: &x, vvop: vvdivf)
    }
    public func moduli(dividingBy: [Element])->[Element]{
        var x = dividingBy
        return perform(with: &x, vvop: vvfmodf)
    }
    public func remainders(dividingBy: [Element])->[Element]{
        var x = dividingBy
        return perform(with: &x, vvop: vvremainderf)
    }
    public func nextAfter(inDirections: [Element])->[Element]{
        var x = inDirections
        return perform(with: &x, vvop: vvnextafterf)
    }
}
