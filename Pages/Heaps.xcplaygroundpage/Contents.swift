
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
}
