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




//-------------------------- Queue -----------------


public struct Queue<Element>{
    private var enqueueStack: Stack <Element> = []
    private var dequeueStack: Stack <Element> = []

    private var storage: [Element] = []
    public mutating func enqueue(_ element: Element){
        enqueueStack.push(element)
    }
    public mutating func dequeue()-> Element?{
        if dequeueStack.isEmpty{
            while !enqueueStack.isEmpty {
                dequeueStack.push(enqueueStack.pop()!)
            }
        }
      return dequeueStack.pop()
    }
    public func peak()-> Element?{
        dequeueStack.isEmpty ? enqueueStack.peak() : dequeueStack.peak()
    }
    
    var isEmpty: Bool {
        enqueueStack.isEmpty && dequeueStack.isEmpty
    }
}

var q = Queue<Int>()

q.enqueue(1)
q.enqueue(2)
q.enqueue(3)

while !q.isEmpty {
    print(q.dequeue())
}
q.enqueue(4)
print(q.dequeue())


