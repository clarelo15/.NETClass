// See https://aka.ms/new-console-template for more information
/*
01 Introduction to C# and Data Types – Questions
1. What type would you choose for the following “numbers”?


A person’s telephone number
- string

A person’s height
- float

A person’s age
- int

A person’s gender (Male, Female, Prefer Not To Answer)
- string

A person’s salary
- decimal

A book’s ISBN
- string

A book’s price
- decimal

A book’s shipping weight
- float or double

A country’s population
- int or long

The number of stars in the universe
- long

The number of employees in each of the small or medium businesses in the United Kingdom (up to about 50,000 employees per business)
- int

2. What are the differences between value type and reference type variables?
   - Value types store the data directly in stack, so assigning a value type variable creates a copy of that data. 
   - Reference types store a memory address to an object in heap, multiple variables can point to the same object.
   What is boxing and unboxing?
   - Boxing is the process of converting a value type to a reference type.
   - Unboxing is the process of converting a reference type back to a value type.

3. What is meant by the terms managed resource and unmanaged resource in .NET?
   - Managed resources are automatically handled by the .NET runtime's garbage collector, 
     which reclaims their memory when they are no longer in use.
   - Unmanaged resources are system resources like file handles or network connections that the garbage collector does not manage,
     requiring manual cleanup by the developer.

4. What is the purpose of the Garbage Collector in .NET?
   - The purpose of the .NET Garbage Collector (GC) is to automatically manage the allocation and deallocation of memory for applications.
     It automatically reclaims the memory used by objects that are no longer referenced by the application, freeing developers from manual memory management. 
     This helps prevent memory leaks and improves the overall stability of the application. 


Controlling Flow and Converting Types – Questions

1. What happens when you divide an int variable by 0?
   - It will cause a runtime error and throw DivideByZeroException.

2. What happens when you divide a double variable by 0?
   - When the numerator is a positive number, the result is Positive Infinity.
   - When the numerator is a negative number, the result is negative Infinity.
   - 0.0 divided by 0.0 gives Not a Number (NaN).

3. What happens when you overflow an int variable (assign a value beyond its range)?
   - It wraps around, resulting in an incorrect and often unexpected value.
   - For a signed integer, this can cause a large positive value to become a large negative one. 

4. What is the difference between x = y++; and x = ++y;?
   - In x = y++;, the original value of y is assigned to x first, and then y is incremented.
   - In x = ++y;, y is incremented first, and then the new incremented value of y is assigned to x. 

5. What is the difference between break, continue, and return when used inside a loop statement?
   - break exits the loop.
   - continue skips the current iteration and immediately begins the next one.
   - return exits the entire function, and a return value back to the calling function.

6. What are the three parts of a for statement and which of them are required?
   - The three parts of a for statement are initialization, condition, and increment/decrement.
   - All three parts are optional, but omitting the condition, can lead to an infinite loop.

7. What is the difference between the = and == operators?
   - The = operator assigns value to a variable.
   - The == operator checks if the values of two operands are equal.

8. Does the following statement compile? for ( ; true; ) ;
   - Yes, it compiles. However, the result is an infinite loop, because the condition is always true.

9. What interface must an object implement to be enumerated by the foreach statement?
   - IEnumerable
*/

/*
Coding：
1. How can we find the minimum and maximum values, as well as the number of bytes, 
   for the following data types: sbyte, byte, short, ushort, int, uint, long, ulong, float, double, and decimal?
*/
Solution1 s1 = new Solution1();
s1.printAll();
Console.WriteLine();

Solution2 s2 = new Solution2();
s2.fizzbuzz(18);
Console.WriteLine();

Solution4 s4 = new Solution4();
int[] arr = {1, 3, 5, 9};
int[] ans = s4.twoSum(arr, 6);
Console.WriteLine($"[{ans[0]}, {ans[1]}]");

public class Solution1
{
    public void printAll()
    {
        // Signed byte
        Console.WriteLine(sbyte.MinValue);
        Console.WriteLine(sbyte.MaxValue);
        Console.WriteLine(sizeof(sbyte));

        // Unsigned byte
        Console.WriteLine(byte.MinValue);
        Console.WriteLine(byte.MaxValue);
        Console.WriteLine(sizeof(byte));

        // Short
        Console.WriteLine(short.MinValue);
        Console.WriteLine(short.MaxValue);
        Console.WriteLine(sizeof(short));

        // Unsigned short
        Console.WriteLine(ushort.MinValue);
        Console.WriteLine(ushort.MaxValue);
        Console.WriteLine(sizeof(ushort));

        // Int
        Console.WriteLine(int.MinValue);
        Console.WriteLine(int.MaxValue);
        Console.WriteLine(sizeof(int));

        // Unsigned int
        Console.WriteLine(uint.MinValue);
        Console.WriteLine(uint.MaxValue);
        Console.WriteLine(sizeof(uint));

        // Long
        Console.WriteLine(long.MinValue);
        Console.WriteLine(long.MaxValue);
        Console.WriteLine(sizeof(long));

        // Unsigned long
        Console.WriteLine(ulong.MinValue);
        Console.WriteLine(ulong.MaxValue);
        Console.WriteLine(sizeof(ulong));

        // Float
        Console.WriteLine(float.MinValue);
        Console.WriteLine(float.MaxValue);
        Console.WriteLine(sizeof(float));

        // Double
        Console.WriteLine(double.MinValue);
        Console.WriteLine(double.MaxValue);
        Console.WriteLine(sizeof(double));

        // Decimal
        Console.WriteLine(decimal.MinValue);
        Console.WriteLine(decimal.MaxValue);
        Console.WriteLine(sizeof(decimal));
    }
}

/*
2. Write a method in C# called FizzBuzz that takes an integer num and prints numbers from 1 up to num, but:
   Print Fizz if the number is divisible by 3.
   Print Buzz if the number is divisible by 5.
   Print FizzBuzz if the number is divisible by both 3 and 5.
   Otherwise, print the number itself.
*/
public class Solution2
{
    public void fizzbuzz(int num)
    {
        for (int i = 1; i <= num; i++)
        {
            if (i % 3 == 0)
            {
                if (i % 5 == 0)
                {
                    Console.WriteLine("FizzBuzz");
                }
                else
                {
                    Console.WriteLine("Fizz");
                }
            }
            else if (i % 5 == 0)
            {
                Console.WriteLine("Buzz");
            }
            else
            {
                Console.WriteLine(i);
            }
        }
    }
}

/*
3. What will happen if this code executes?
   int max = 500;
   for (byte i = 0; i < max; i++)
   {
       Console.WriteLine(i);
   }
*/
// The program will never stop. Infinite loop printing 0 to 255 repeatedly.
// public class Solution3
// {
//     public static void Main()
//     {
//         int max = 500;
//         for (byte i = 0; i < max; i++)
//         {
//             Console.WriteLine(i);
//         }
//     }
// }

/*
4. Two Sum
   Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
   You may assume that each input would have exactly one solution.
   You may not use the same element twice.
   You can return the answer in any order.
*/
public class Solution4
{
    public int[] twoSum(int[] arr, int target)
    {
        int[] res = new int[2];
        Dictionary<int, int> map = new Dictionary<int, int>();
        for (int i = 0; i < arr.Length; i++)
        {
            int complement = target - arr[i];
            if (map.ContainsKey(complement))
            {
                res[0] = map[complement];
                res[1] = i;
            }
            if (!map.ContainsKey(arr[i]))
            {
                map[arr[i]] = i;
            }

        }
        return res;
    }
}
