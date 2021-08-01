
public struct Heap<Element: Equatable>{
    
    var elements: [Element] = []
    var sort: (Element, Element)-> Bool
    
    init(sort: @escaping (Element, Element)-> Bool ) {
        self.sort = sort
    }
    var isEmpty: Bool{
        elements.isEmpty
    }
    var count: Int{
        elements.count
    }
    func peak()-> Element?{
        elements.first
    }
    func leftChildIndex(of index: Int)-> Int{
        2*index + 1
    }
    func rightChildIndex(of index: Int)->Int{
        2*index + 2
    }
    func parentIndex(of index: Int)->Int{
        (index-1)/2
    }
    
    mutating func remove()-> Element?{
        if isEmpty {return nil}
        elements.swapAt(0, count-1)
        defer {
            
        }
        return elements.removeLast()
    }
    
    private mutating func siftDown(from index: Int){
        var parent = index
        while true {
            let rightChild = rightChildIndex(of: parent)
            let leftChild = leftChildIndex(of: parent)
            var candidate = parent
            if leftChild < count && sort(elements[leftChild], elements[candidate]){
                candidate = leftChild
            }
            if rightChild < count && sort(elements[rightChild], elements[candidate]){
                candidate = rightChild
            }
            if candidate == parent {return}
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    
    public mutating func insert(_ elemnt: Element){
        elements.append(elemnt)
        siftUp(from: elements.count - 1)
        
    }
    
    private mutating func siftUp(from index : Int){
        var child = index
        var parent = parentIndex(of: child)
        while child > 0 &&  sort(elements[child], elements[parent]) {
            elements.swapAt(child, parent)
            child = parent
            parent = parentIndex(of: child)
        }
    }
    public mutating func remove(at index: Int) -> Element?{
        guard  index < elements.count else {
            return nil
        }
        if index == elements.count - 1{
            return elements.removeLast()
        }
        elements.swapAt(elements.count-1, index)
        defer {
            siftDown(from: index)
            siftUp(from: index)
        }
        return elements.removeLast()
    }
    func index(of element: Element, startingAt i: Int)->Int?{
        if i > count {return nil}
        if sort(element, elements[i]){return nil}
        if let l = index(of: element, startingAt: leftChildIndex(of: i)){
            return l
        }
        if let r = index(of: element, startingAt: rightChildIndex(of: i)){
            return r
        }
        return nil
    }
    
}
