// See https://aka.ms/new-console-template for more information
/*
OOP Q&A
1. What are the six combinations of access modifier keywords and what do they do?
   - public: Access is not restricted and is available to any code in the same project or a referencing project.
   - private: Access is limited to the same class or struct. It is the most restrictive access level.
   - internal: Access is limited to the current assembly (.exe or .dll).
   - protected: Access is limited to the same class and any types derived from that class.
   - protected internal: Access is available to the same assembly and derived class, even in a different assembly.
   - private protected: Access is available only within the same assembly and derived class from the same assembly. 

2. What is the difference between the static, const, and readonly keywords when applied to a type member?
   - A const is a compile-time constant. const can only be applied to primitive value types and enum types.
     Once a const is assigned a value during its declaration, that value cannot be changed later in the code.
   - A static field whose value must be assigned at declaration and cannot change.
     Applicable to all member types (fields, methods, properties).
   - A readonly field can be an instance or static member, is initialized at declaration or in a constructor,
     and its value cannot be changed after the constructor exits. 

3. What does a constructor do?
   - A constructor is a special method when an object of a class is created.
     Its purpose is to initialize the new object's state, such as assigning initial values to its fields,
     to ensure it is in a valid and usable condition from the moment it is created.

4. Why is the partial keyword useful?
   - The partial keyword is useful for splitting the definition of a single class, struct, or interface across multiple files. 

5. What is a tuple?
   - A tuple is a lightweight data structure that can group multiple elements of different data types into a single object.
   - Tuples are used for returning multiple values from a method without having to create a custom class or use out parameters.

6. What does the C# record keyword do?
   - The record keyword in C# creates a special type of class or struct designed for encapsulating data.
     It automatically generates boilerplate code for common data-centric operations, providing value equality,
     concise syntax, and built-in functionality for immutability and non-destructive mutation. 

7. What does overloading and overriding mean?
   - Overloading allows a class to have more than one method having the same name with different parameter lists.
   - Overriding is when a subclass redefines a method that already exists in its parent class, using the exact same method signature.

8. What is the difference between a field and a property?
   - A field is a simple variable that stores data directly within a class or struct.
   - A property is a special member that provides controlled, indirect access to a private field using get and set.

9. How do you make a method parameter optional?
   - Assign a default value to it in the method's signature. Optional parameters must be placed at the end of the parameter list,
     after any required parameters. If a value is not provided when the method is called, the default value is used.

10. What is an interface and how is it different from an abstract class?
    - An interface is a contract that defines a set of methods and properties that a class must implement,
      without providing any implementation details.
    - An abstract class can contain both abstract members and concrete members, and is designed to be inherited by a subclass.
    - The key difference is that a class can implement multiple interfaces, but can only inherit from a single abstract class.

11. What accessibility level are members of an interface by default?
    - Public by default. The interface is to define a contract, and that contract must be accessible to any class that implements it. 

12. True/False: Polymorphism allows derived classes to provide different implementations of the same method.
    - True

13. True/False: The override keyword is used to indicate that a method in a derived class is providing its own implementation.
    - True

14. True/False: The new keyword is used to indicate that a method in a derived class is providing its own implementation.
    - False

15. True/False: Abstract methods can be used in a normal (non-abstract) class.
    - False

16. True/False: Normal (non-abstract) methods can be used in an abstract class.
    - True

17. True/False: Derived classes can override methods that were virtual in the base class.
    - True

18. True/False: Derived classes can override methods that were abstract in the base class.
    - True

19. True/False: Derived classes must override the abstract methods from the base class.
    - False

20. True/False: In a derived class, you can override a method that was neither virtual nor abstract in the base class.
    - False

21. True/False: A class that implements an interface does not have to provide an implementation for all of the members of the interface.
    - False

22. True/False: A class that implements an interface is allowed to have other members in addition to the interface members.
    - True

23. True/False: A class can inherit from more than one base class.
    - False

24. True/False: A class can implement more than one interface.
    - True

*/

/*
Create 3 classes in Program.cs:
a. Person class
Create an abstract class Person with the following members:
An Id property (int).
A private field salary with a public property Salary that only accepts positive values; throw an exception if a negative value is assigned.
A DateOfBirth property (DateTime).
An Address property (List of strings).
*/
public abstract class Person
{
    public int Id { get; set; }
    private decimal salary;
    public decimal Salary
    {
        get { return salary; }
        set
        {
            if (value < 0)
            {
                throw new ArgumentOutOfRangeException("Salary must be positive.");
            }
            salary = value;
        }
    }
    public DateTime DateOfBirth { get; set; }
    public List<string> Address { get; set; } = new List<string>();
}

/*
b. Instructor class
Create a class Instructor that inherits from Person.
Add a DepartmentId property (int).
*/
public class Instructor : Person
{
    public int DepartmentId{ get; set; }
}

/*
c. Student class
Create a class Student that inherits from Person.
Add a property SelectedCourses, which is a list of Course objects.
*/
public class Course
{
    public string CourseName { get; set; }
}

public class Student : Person
{
    public List<Course> SelectedCourses { get; set; } = new List<Course>();
}