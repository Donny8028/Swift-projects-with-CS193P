  //
//  ＣalculatorBrain.swift
//  Calculator2
//
//  Created by 賢瑭 何 on 2016/2/6.
//  Copyright © 2016年 Donny. All rights reserved.
//

import Foundation
  
  class CalculatorBrain  {
    
    private enum Op: CustomStringConvertible {
        case operand(Double)
        case unaryOperation(String,(Double) ->Double)
        case binaryOperation(String,(Double, Double) -> Double)
        
        var description:String {
        get{
            switch self{
            case .operand(let opperand) :
                return "\(opperand)"
            case .unaryOperation(let symbol,_ ) :
                return "\(symbol)"
            case .binaryOperation(let symbol,_) :
                return "\(symbol)"
                
                }
            }

        }
    }
    
    private var opStack = [Op]()
    
    private var knownOp = [String:Op]()
    
    init() {
        func opperation (symbol:String){
            
        }
        knownOp["+"] = Op.binaryOperation("+", + )
        knownOp["−"] = Op.binaryOperation("−"){$1 - $0}
        knownOp["×"] = Op.binaryOperation("×", * )
        knownOp["÷"] = Op.binaryOperation("÷"){$1 / $0}
        knownOp["√"] = Op.unaryOperation("√", sqrt)
            
    }
    
    var program:AnyObject {
        get {
           return opStack.map{$0.description}
        }
        set {
            if let symbols = newValue as? Array<String> {
                var newOpStack = [Op]()
                for symbol in symbols {
                    if let op = knownOp[symbol]{
                        newOpStack.append(op)
                        
                    }else if let operands = NSNumberFormatter().numberFromString(symbol)?.doubleValue{
                        newOpStack.append(.operand(operands))
                    }
                }
        opStack = newOpStack
            }
        }
    }
    
    
    private func evaluate (ops: [Op]) -> (result: Double? , remainingOps: [Op]) {
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op {
            case .operand(let opperand) :
                return ( opperand , remainingOps)
            case .unaryOperation(_, let operation) :
                let evaluation = evaluate(remainingOps)
                if let opperand = evaluation.result {
                return (operation(opperand) , evaluation.remainingOps)
                }
            case .binaryOperation(_,let operation) :
                let evaluation1 = evaluate(remainingOps)
                if let opperand1 = evaluation1.result {
                    let evaluation2 = evaluate(evaluation1.remainingOps)
                    if let opperand2 = evaluation2.result {
                        return (operation(opperand1 , opperand2) , evaluation2.remainingOps)
                    }
                }
            }
        }
        return (nil , ops)
    }
    
    
    
    
    
    
    func evlauate () -> Double? {
        
        let (result, remainder) = evaluate(opStack)
        print("\(opStack) is the array , result = \(result) and \(remainder) left.")
        return result
    }
    
    func pushOperand (operand: Double) -> Double?{
        let operand = Op.operand(operand)
        opStack.append(operand)
        return evlauate()
    }
    
    
    func pushOperation (Symbol: String) -> Double?{
        if let operation = knownOp[Symbol] {
            opStack.append(operation)
        }
        return evlauate()
    }
    
    
  }
  
  
  
  
  
  
  
