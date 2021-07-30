public struct Stack<Element>{
    
    private var storage: [Element] = []
    
    
    public mutating func push(_ element: Element){
        storage.append(element)
    }
    @discardableResult
    public mutating func pop()-> Element? {
        storage.popLast()
    }
    
    public func peak()-> Element{
        storage[storage.count-1]
    }
    var isEmpty: Bool{
        storage.isEmpty //peak() == nil
    }
}
// make intialization with array literal possible[]
// var stack :Stack<> = []
extension Stack: ExpressibleByArrayLiteral{
    public init(arrayLiteral elements: Element...){
        storage = elements
    }
}
