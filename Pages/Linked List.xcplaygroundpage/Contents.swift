
public class Node<Value>{
    public var val: Value
    public var next: Node?
    init(val: Value, next: Node? = nil ) {
        self.val = val
    }
}
public struct LinkedList<Value>{
    public var head: Node<Value>?
    public var tail: Node<Value>?
    
    public var isEmpty: Bool{
        return head == nil
    }
    public mutating func append(val: Value){
        let newNode = Node(val: val)
        if isEmpty {
            head = newNode
        }
        tail?.next = newNode
        tail = newNode
    }
    
    public mutating func push(val: Value){
        head = Node(val: val, next: head)
        if tail == nil {
            tail = head
        }
    }
    public mutating func pop()->Node<Value>?{
        if isEmpty {return nil}
        let node = head
        head = head?.next
        return node
    }
    public mutating func insert(_ val: Value, after index: Int){
        let beforeNode = node(at: index)
        let newNode = Node(val: val, next: beforeNode?.next)
        beforeNode?.next = newNode
    }
    private func node(at index: Int)-> Node<Value>?{
        var curr = head
        var currIndex = 0
        while curr != nil && currIndex < index{
            curr = curr?.next
            currIndex += 1
        }
        return curr
    }
    
}

extension Node: CustomStringConvertible {
  public var description: String {
    guard let next = next else {
      return "\(val)"
    }
    return "\(val) -> " + String(describing: next) + " "
  }
}

var list = LinkedList<Int>()
list.push(val: 3)
list.push(val: 2)
list.push(val: 1
)

print("\(list)")

