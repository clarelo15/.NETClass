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

public class GenericRepository<T> : IGenericRepository<T> where T : class
{
    private List<T> list;

    public GenericRepository()
    {
        list = new List<T>();
    }
    public void Add(T item)
    {
        list.Add(item);
    }
    public void Remove(T item)
    {
        list.Remove(item);
    }
    public void Save()
    {
    }
    public IEnumerable<T> GetAll()
    {
        return list;
    }
    public T? GetById(int id)
    {
        var property = typeof(T).GetProperty("Id");
        if (property == null)
        {
            throw new InvalidOperationException("No 'Id' property.");
        }
        return list.SingleOrDefault(item => (int)property.GetValue(item)! == id);
    }
}