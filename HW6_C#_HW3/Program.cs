// See https://aka.ms/new-console-template for more information
/*
1. Describe the problem generics address.
   Generics address the problem of code reuse and type safety by allowing a class, method, or interface
   to work with data of any type while enforcing compile-time type checking.
   Without generics, developers would either have to use a less type-safe object type (requiring manual casting and increasing the risk of runtime errors)
   or write separate, nearly identical code for each specific data type. Generics prevent this code duplication and reduce the risk of type-related errors.

2. How would you create a list of strings, using the generic List class?
   List<string> list = new List<string>();

3. How many generic type parameters does the Dictionary class have?
   Two generic type parameters. One for the key and one for the value.
   Dictionary<TKey, TValue>

4. True/False. When a generic class has multiple type parameters, they must all match.
   False

5. What method is used to add items to a List object?
   Add() method is used to add items to a List object. This method adds a single item to the end of the list.
   List<int> numbers = new List<int>();
   numbers.Add(1);

6. Name two methods that cause items to be removed from a List.
   Remove(item): Removes the first occurrence of a specific item from the list.
   RemoveRange(index, count): Removes a range of elements from the list.

7. How do you indicate that a class has a generic type parameter?
   To indicate that a class has a generic type parameter, append the type parameter name inside angle brackets (< >) to the class name.
   For example, public class MyClass<T>. You can also specify constraints on the type parameter within the class definition.

8. True/False. Generic classes can only have one generic type parameter.
   False

9. True/False. Generic type constraints limit what can be used for the generic type.
   True

10. True/False. Constraints let you use the methods of the thing you are constraining to.
    True
*/

/*
Task 1:
Define a generic class called MyStack<T> with the following requirements:
1. Use Stack<T> internally to store the data.
2. Implement a Count() method that returns the number of elements in the stack.
3. Implement a Pop() method that returns and removes the top element of the stack.
4. Implement a Push(T obj) method that adds an element to the stack.
Finally, create an instance of MyStack<int>, push two integers into it, and print out the current number of elements in the stack.
*/
MyStack<int> myStack = new MyStack<int>();
myStack.Push(3);
myStack.Push(6);
Console.WriteLine(myStack.Count());
public class MyStack<T>
{
    private Stack<T> stack = new Stack<T>();

    public int Count()
    {
        return stack.Count;
    }
    public T Pop()
    {
        if (stack.Count() == 0)
        {
            throw new InvalidOperationException("Stack is empty.");
        }
        return stack.Pop();
    }
    public void Push(T item)
    {
        stack.Push(item);
    }
}
