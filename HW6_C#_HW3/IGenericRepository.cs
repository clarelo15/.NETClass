/*
Task 2:
Create a generic repository pattern in C# with the following requirements:
1. Define a generic interface IGenericRepository<T> where T : class.
   The interface should declare the following methods:
     Add(T item)
     Remove(T item)
     Save()
     IEnumerable<T> GetAll()
     T GetById(int id)
2. Implement a class GenericRepository<T> that inherits from IGenericRepository<T>.
   Use a private List<T> field to store the data.
   In the constructor, initialize the list as a new empty List<T>.
   Provide method implementations for Add, Remove, GetAll, GetById. No actual implementation is needed for Save.
*/
public interface IGenericRepository<T> where T : class
{
    void Add(T item);
    void Remove(T item);
    void Save();
    IEnumerable<T> GetAll();
    T? GetById(int id);
}