public class BinaryTreeNode<T>{
    public var val: T
    public var leftChild: BinaryTreeNode?
    public var rightChild: BinaryTreeNode?

    init(_ val: T) {
        self.val = val
    }
    
    public func inOrderTraverse(_ root: BinaryTreeNode?){
        if root == nil {return}
        inOrderTraverse(root?.leftChild)
        print(root!.val)
        inOrderTraverse(root?.rightChild)
    }
    
}

public struct BinarySearchTree<T: Comparable>{
    private(set) var root: BinaryTreeNode<T>?
    
    public mutating func insert(_ val: T){
        insert(root, val)
    }
    private mutating func insert(_ root: BinaryTreeNode<T>?, _ val: T){
        if val > root!.val{
            if root?.rightChild == nil {
                root?.rightChild = BinaryTreeNode(val)
                return
            }
            insert(root?.rightChild, val)
        }else{
            if root?.leftChild == nil {
                root?.leftChild = BinaryTreeNode(val)
                return
            }
            insert(root?.leftChild, val)
        }
    }
    
    func contains(_ val: T) -> Bool {
        var curr = root
        while curr != nil {
            if val == curr?.val {return true}
            if val < curr!.val{
                curr = curr?.leftChild
            }else{
                curr = curr?.rightChild
            }
        }
        return false
    }
    public mutating func remove(_ val: T){
        root = remove(root, val)
    }
    private mutating func remove(_ root: BinaryTreeNode<T>?,_ val: T)-> BinaryTreeNode<T>?{
        guard let node = root else {
            return nil
        }
        if node.val == val{
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            node.val = node.rightChild!.min.val
            node.rightChild = remove(node.rightChild, node.val)
            
        }else if val < node.val{
            node.leftChild = remove(node.leftChild, val)
        }else {
            node.rightChild = remove(node.rightChild, val)
        }
        return node
    }
    
    public func height(_ root: BinaryTreeNode<T>?)->Int{
        CalculateHeight(root)
    }
    private func CalculateHeight(_ root: BinaryTreeNode<T>?)->Int{
        if root == nil {return 0}
        if root?.rightChild == nil && root?.leftChild == nil{
            return 0
        }
        if root?.rightChild == nil && root?.leftChild != nil{
            return 1 + CalculateHeight(root?.leftChild)
        }
        if root?.rightChild != nil && root?.leftChild == nil{
            return 1 + CalculateHeight(root?.rightChild)
    }
        else{
            return 1 + max(CalculateHeight(root?.rightChild), CalculateHeight(root?.leftChild))
        }
    }
    
}

private extension BinaryTreeNode{
    var min: BinaryTreeNode{
        return leftChild?.min ?? self
    }
    
}
