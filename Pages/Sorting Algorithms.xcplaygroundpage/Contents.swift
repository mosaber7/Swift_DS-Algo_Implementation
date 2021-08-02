

//-----------------selectionSort---------------

func selectionSort<Element: Comparable>(_ arr: inout [Element]){
    guard arr.count >= 2 else {
        return
    }
    for curr in 0..<arr.count{
        var lowest = curr
        for runner in curr..<arr.count{
            if arr[runner] < arr[lowest]{
                lowest = runner
            }
        }
        if lowest != curr {
            arr.swapAt(lowest, curr)
        }
    }
    
}

var test = [3,-1,1,4]
selectionSort(&test)
print(test)


//----------------- bubleSORT --------------------

public func bubleSort<Element: Comparable>(_ arr: inout [Element]){
    
}
