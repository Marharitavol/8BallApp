import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

func deadlock() {
    let queue = DispatchQueue(label: "com.gcd.serial")
    queue.async {
        print("A")
        DispatchQueue.main.sync {
            print("B")
        }
    }

    queue.sync {
        print("C")
    }
}

func cancellationOfDispatchWorkItem() {
    let queue = DispatchQueue.global(qos: .background)
    var item: DispatchWorkItem?
    
    item = DispatchWorkItem {
        while true {
            if item?.isCancelled ?? true { break }
            print("0")
        }
    }
    
    guard let _ = item else { return }
    queue.async(execute: item!)
    
    queue.asyncAfter(deadline: .now() + 2) {
        item?.cancel()
    }
}
