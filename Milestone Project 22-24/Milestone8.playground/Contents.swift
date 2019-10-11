import UIKit

// MARK: Creating an Extension for UIView that has a bounceOut(duration: ) animation method

extension UIView {
    func bounceOut(duration: TimeInterval) {
        UIView.animate(withDuration: duration) {
            [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        }
    }
}

// MARK: Creating an Extension for Int that has a times method that will run a closure

extension Int {
    
    func times(printHello: () -> Void) {
        guard self > 0 else { return }
        
        for _ in 0..<self {
            printHello()
        }
    }
}

// MARK: Creating an Extension for Array that has mutating remove(at: ) method to remove an element in the array

extension Array where Element:Comparable {
    mutating func remove(item: Element) {
        if let location = self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}



