import Foundation

class CalculatorViewModel: ObservableObject {
    @Published var display = "0"
    @Published var previousValue: Double = 0
    @Published var currentOperation: Operation = .none
    @Published var shouldResetDisplay = false
    
    enum Operation {
        case none, add, subtract, multiply, divide
    }
    
    func numberTapped(_ number: Int) {
        if shouldResetDisplay {
            display = String(number)
            shouldResetDisplay = false
        } else {
            if display == "0" {
                display = String(number)
            } else {
                display += String(number)
            }
        }
    }
    
    func decimalTapped() {
        if !display.contains(".") {
            display += "."
            shouldResetDisplay = false
        }
    }
    
    func operationTapped(_ operation: Operation) {
        previousValue = Double(display) ?? 0
        currentOperation = operation
        shouldResetDisplay = true
    }
    
    func equalsTapped() {
        guard let current = Double(display) else { return }
        
        let result: Double
        
        switch currentOperation {
        case .add:
            result = previousValue + current
        case .subtract:
            result = previousValue - current
        case .multiply:
            result = previousValue * current
        case .divide:
            result = previousValue / current
        case .none:
            result = current
        }
        
        // Remove unnecessary decimals
        if result.truncatingRemainder(dividingBy: 1) == 0 {
            display = String(Int(result))
        } else {
            display = String(result)
        }
        
        currentOperation = .none
        shouldResetDisplay = true
    }
    
    func clearTapped() {
        display = "0"
        previousValue = 0
        currentOperation = .none
        shouldResetDisplay = false
    }
    
    func backspaceTapped() {
        if display.count > 1 {
            display.removeLast()
        } else {
            display = "0"
        }
    }
}
