public class TrieNode<Key: Hashable>{
    
    public var key: Key?
    public var parent: TrieNode?
    public var children: [Key: TrieNode] = [:]
    public var isTerminating = false
    
    init(key: Key?, parent: TrieNode?) {
        self.key = key
        self.parent = parent
    }
}
public class Trie<collectiontype: Collection> where collectiontype.Element: Hashable{
    
    typealias Node = TrieNode<collectiontype.Element>
    let root = Node(key: nil, parent: nil)
    
    public func insert(_ collection: collectiontype){
        var curr = root
        
        for element in collection {
            if curr.children[element] == nil {
                curr.children[element] = Node(key: element, parent: curr)
            }
            curr = curr.children[element]!
        }
        curr.isTerminating = true
        
    }
    func suggestedProducts(_ products: [String], _ searchWord: String) -> [String] {
        var results = [String]()
        var curr: TrieNode<collectiontype.Element>? = nil
        for (index, _) in searchWord.enumerated(){
            let stringIndex = searchWord.index(searchWord.startIndex, offsetBy: index)
            let substring = searchWord[searchWord.startIndex...stringIndex] as! String
            let resultTuple = contains(substring as! collectiontype)
            curr = resultTuple.1
            guard let result = resultTuple.0 else{
                return []
            }
            if curr!.isTerminating{
                results.append(substring as! String)
            }else {
                
            }
        }
        return results
    }
    
    private func contains(_ collection: collectiontype)-> ([TrieNode<collectiontype.Element>]?, TrieNode<collectiontype.Element>){
        var curr = root
        var result: [TrieNode<collectiontype.Element>] = []
        for element in collection {
            guard let child = curr.children[element] else {
                
                return (nil,curr)
            }
            result.append(child)
            curr = child
        }
        return (result, curr)
    }
    
    
}

func suggestedProducts(_ products: [String], _ searchWord: String) -> [[String]] {
    var trie = Trie<String>()
    for product in products {
        trie.insert(product)
    }
    print(trie)
    return []
}
suggestedProducts(["mo", "saber", "mohamed", "mom"], "m")


func contains(_ arr: [Int], target: Int)->Bool{
    binarySerch(arr, target: target, 0, arr.count-1)
}
private func binarySerch(_ arr: [Int], target: Int, _ low: Int, _ high: Int)->Bool{
    if low >= high {return false}
    let lowIndex = arr.index(arr.startIndex, offsetBy: low)
    let highIndex = arr.index(arr.startIndex, offsetBy: high)
    let middileIndex: Int = lowIndex + highIndex / 2
    
    if arr[middileIndex] == target {return true}
    if target > arr[middileIndex]{
        return binarySerch(arr, target: target, middileIndex, high)
    }else {
        return binarySerch(arr, target: target, low, middileIndex)
    }
}
contains([1,2,3,4,5], target: 5)




public struct Heap<Element: Equatable>{
    private var elements: [Element] = []
    var sort:  (Element, Element)-> Bool
    init(sort: @escaping (Element, Element)-> Bool) {
        self.sort = sort
    }
    var count: Int {
        return elements.count
    }
    
    public func rightChildIndex(of parentIndex: Int)-> Int{
        2*parentIndex + 2
    }
    public func leftChildIndex(of parentIndex: Int)-> Int{
        2*parentIndex + 1
    }
    public func parentindex(of childIndex: Int)-> Int{
        (childIndex - 1) / 2
    }
    public func peak()-> Element?{
        elements.first
    }
    
    public mutating func insert(_ element: Element){
        elements.append(element)
        siftUp(from: elements.count - 1)
    }
    private mutating func siftDown(from index: Int){
        var parent = index
        while true {
            let right = rightChildIndex(of: parent)
            let left = leftChildIndex(of: parent)
            var candidate = parent
            if left < count && right < count {
                if sort(elements[left], elements[parent]) && sort(elements[left], elements[right]) {
                    candidate = left
                }
                if  sort(elements[right], elements[parent]) && !sort(elements[left], elements[right]) {
                    
                    candidate = right
                    
                }
            }
            
            
            if candidate == parent {return}
            elements.swapAt(parent, candidate)
            parent = candidate
        }
    }
    private mutating func siftUp(from index: Int){
        var child = index
        var parent = parentindex(of: child)
        while child > 0 && sort(elements[child], elements[parent]){
            elements.swapAt(child, parent)
            child = parent
            parent = parentindex(of: child)
        }
    }
    public mutating func remove() -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        elements.swapAt(0, count - 1)
        defer {
            siftDown(from: 0) // 4
        }
        return elements.removeLast()
    }
}
func lastStoneWeight(_ stones: [Int]) -> Int {
    var heap = Heap<Int>(sort: >)
    
    for stone in stones{
        heap.insert(stone)
    }
    var outputHeap = getlastStoneWeight(heap)
    return outputHeap.remove() ?? 0
}
private func getlastStoneWeight(_ heap: Heap<Int>) -> Heap<Int>{
    var currHeap = heap
    while currHeap.count > 1 {
        
        let max1 = currHeap.remove()!
        let max2 = currHeap.remove()!
        
        if max1 == max2 {continue}
        
        currHeap.insert(max1-max2)
        
    }
    
    return currHeap
}
print(lastStoneWeight([9,3,2,10]))

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
    var count: Int {
        return storage.count
    }
}

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
func hasPathSum(_ root: TreeNode?, _ targetSum: Int) -> Bool {
    var nodesStack = Stack<TreeNode>()
    var targetSumStack = Stack<Int>()
    nodesStack.push(root!)
    targetSumStack.push(targetSum - root!.val)
    while !nodesStack.isEmpty {
        var currNode = nodesStack.pop()!
        var currSum = targetSumStack.pop()!
        
        if currNode.left == nil && currNode.right == nil && currSum == 0 {
            return true
        }
        if currNode.left != nil {
            nodesStack.push(currNode.left!)
            targetSumStack.push(currSum - currNode.left!.val)
            
        }
        if currNode.right != nil {
            nodesStack.push(currNode.right!)
            targetSumStack.push(currSum - currNode.right!.val)
            
        }
        
    }
    return false
}


  public class Node {
      public var val: Int
      public var children: [Node]
      public init(_ val: Int) {
          self.val = val
          self.children = []
      }
  }
public class Queue<Element>{
    private var enequeStack = Stack<Element>()
    private var dequeStack = Stack<Element>()
    
    public func enqueue(_ element: Element){
        enequeStack.push(element)
    }
    public func dequeue()-> Element?{
        if dequeStack.isEmpty{
            while !enequeStack.isEmpty {
                dequeStack.push(enequeStack.pop()!)
            }
        }
       return dequeStack.pop()
    }
    var isEmpty: Bool {
        enequeStack.isEmpty && dequeStack.isEmpty
    }
    var count: Int {
        enequeStack.count + dequeStack.count
    }
    
    
}



func levelOrder(_ root: Node?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var q = Queue<Node>()
    var output = [[Int]]()
    q.enqueue(root)
    while !q.isEmpty {
        var levelArr = [Int]()
       
        let levelElementsCount = q.count
        
        for _ in 0..<levelElementsCount{
            let curr = q.dequeue()
            levelArr.append(curr!.val)
            for child in curr!.children{
                q.enqueue(child)
            }
        }
        output.append(levelArr)
        
}
    return output
}

func levelOrder2(_ root: Node?) -> [[Int]] {
    guard let root = root else {
        return []
    }
    var q = Queue<Node>()
    var output = [[Int]]()
    q.enqueue(root)
    while !q.isEmpty {
        let levelCount = q.count
        
        var levelArr = [Int]()
        for _ in 0..<levelCount {
            let curr = q.dequeue()
            levelArr.append(curr!.val)
            curr!.children.forEach{q.enqueue($0)}
        }
        output.append(levelArr)
    }
    return output
    
}

func preorder(_ root: Node?) -> [Int] {
    guard let root = root else {
        return []
    }
    var s = Stack<Node>()
    var output = [Int]()
    
    s.push(root)
    while !s.isEmpty {
        let curr = s.pop()!
        for child in curr.children.reversed(){
            s.push(child)
        }
        output.append(curr.val)
    }
    return output
    }

func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var output = [Int]()
    guard let root = root else {
        return []
    }
    getPreorderTraversal(root, &output)
    return output
    }
private func getPreorderTraversal(_ root: TreeNode?, _ arr: inout [Int]){
    if root == nil {
        return
    }
    arr.append(root!.val)
    getPreorderTraversal(root!.left, &arr )
    getPreorderTraversal(root!.right, &arr)
}

func inorderTraversal(_ root: TreeNode?) -> [Int] {
    guard let root =  root else {
        return []
    }
    var output = [Int]()
    getInorderTraversal(root, &output)
    return output
    }
private func getInorderTraversal(_ root: TreeNode?, _ arr : inout [Int]){
    getInorderTraversal(root?.left, &arr)
    arr.append(root!.val)
    getInorderTraversal(root?.right, &arr)
}

func postorder(_ root: Node?) -> [Int] {
    guard let root = root else {
        return []
    }
    var output = [Int]()
    getPostOrder(root, &output)
    return output
    }
private func getPostOrder(_ root: Node?, _ arr: inout [Int]){
    if root == nil {return}
    root!.children.forEach{getPostOrder($0, &arr)}
    arr.append(root!.val)
    
}

func maxDepth(_ root: Node?) -> Int {
    guard let root = root else {
        return 0
    }
    var nodesQueue = Queue<Node>()
    var depth = 0

    nodesQueue.enqueue(root)
    while !nodesQueue.isEmpty {
        var levelCount = nodesQueue.count
        depth += 1
        for _ in 0..<levelCount{
        let curr = nodesQueue.dequeue()!
        curr.children.forEach{nodesQueue.enqueue($0)}
    }
    }
    return depth
    }
