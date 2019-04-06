
# 50 Python Commands

Article digest from [The Python Book, 8/e](https://www.amazon.com/Python-Book-Magazine-Issue-2018/dp/B07CR3BBWW) published by Future PLC, 2018

--

## 01. Importing modules

The strength of Python it its ability to be extended through
modules. The first step in many programs is to just call 

```
import modulename
```

In this case, those functions and objects provided are not in the
general namespace. You need to call them using the complete name
`modulename.methodname`. You can shorten the modulename part with the
command

```
import modulename as mn
```

You can skip this issue completely with the command 

```
from modulename import *
```

to import everything from the given module. Then you can call those
provided capabilities directly. If you only need a few of the provided
items, you can import them selectively by replacing the `*` with the
method or object names.

```
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import scipy
>>> scipy.sin(45.6)
0.9989000907450211
>>> reload(scipy)
<module 'scipy' from '/usr/local/src/python/learning/the_fifty/fiftyenv/lib/python2.7/site-packages/scipy/__init__.pyc'>
>>> 
```

## 02. Reloading modules

When a module is first imported, any initialization functions are run
at that time. This may involve creating data objects, or initiating
connections. But, this is only done the first time within a given
session. Importing the same module again won't re-execute any of the
initialization code. If you want to have this code re-run, you need to
use the reload command. The format is 

```
reload(modulename)
```

Something to keep in mind is that the dictionary from the previous
import isn't deleted, but only written over. This means that any
definitions that have changed between the import and the reload are
updated correctly. But if you delete a definition, the old one will
get restored and become accessible. There may be other side effects,
so always use with caution.

## 03. Installing new modules

While most of the commands we are looking at are Python commands that
are to be executed within a Python session, there are a few essential
commands that need to be executed outside of the Python
interpreter. The first of these is `pip`. Installing a module involves
downloading the source code, and compiling any included external
code. Luckily, there is a repository of hundreds of Python modules
available at [http://pypi.python.org](http://pypi.python.org). Instead
of doing everything manually, you can install a new module by using
the command `pip install modulename`. This command will also do a
dependency check and install any missing modules before installing the
one you requested. You may need administrator rights if you want this
module installed in the global library for your computer. On a Linux
machine, you would simply run the pip command with sudo. Otherwise,
you can install it to your personal library directory by adding the
command line option `--user`.

Alternatively, modules can be installed into a Python virtualenv:

```
ubuntu@myhost:~/the_fifty$ /opt/local/Python-2.7.15/bin/virtualenv fiftyenv
New python executable in ~/the_fifty/fiftyenv/bin/python
Installing setuptools, pip, wheel...
done.
ubuntu@myhost:~/the_fifty$ . ./fiftyenv/bin/activate
(fiftyenv) ubuntu@myhost:~/the_fifty$ pip install scipy
DEPRECATION: Python 2.7 will reach the end of its life on January 1st, 2020. Please upgrade your Python as Python 2.7 won't be maintained after that date. A future version of pip will drop support for Python 2.7.
Collecting scipy
  Downloading https://files.pythonhosted.org/packages/a2/88/7e7030080e14bf0b3193
f759e3d9799f80e41f9bb8c49f2dc5f4be552a9d/scipy-1.2.1-cp27-cp27m-manylinux1_x86_6
4.whl (24.8MB)
    100% |################################| 24.8MB 727kB/s
Collecting numpy>=1.8.2 (from scipy)
  Downloading https://files.pythonhosted.org/packages/65/9e/f7fe595f62b8f7fcc154afb20df19b58ddf2723ca2e21dbbf749cd1b8e0c/numpy-1.16.2-cp27-cp27m-manylinux1_x86_64.whl (17.0MB)
    100% |################################| 17.0MB 770kB/s
Installing collected packages: numpy, scipy
Successfully installed numpy-1.16.2 scipy-1.2.1
```

Yet another option is to use [conda](https://conda.io/en/latest/) to
manage modules in separate Python environments.

## 04. Executing a script

Importing a module does run the code within the module file, but does
it through the module maintenance code within the Python engine. This
maintenance code also deals with running initializing code. If you
only wish to take a Python script and execute the raw code within the
current session, you can use the `execfile("filename.py")` command,
where the parameter `filename.py` is a string which names the Python
file to load and execute. By default, any definitions are loaded into
the locals and globals of the current session. You can optionally
include two extra parameters to the execfile command. These two
options are both dictionaries, one for a different set of locals and
another for a different set of globals. If you only hand in one
dictionary, it is assumed to be the globals dictionary. The return
value of this command is `None`.

## 05. An enhanced shell

The default interactive shell is provided through the command `python`,
but is rather limited. An enhanced shell is provided by the command
`ipython`. It provides a lot of extra functionality to the code
developer. A thorough history system is available, giving you access
to not only commands from the current session, but also from previous
sessions. There are also magic commands that provide enhanced ways of
interacting with the current Python session. For more complex
interactions, you can create and use macros. You can also easily peek
into the memory of the Python session and decompile Python code. You
can even create profiles that allow you to handle initialization steps
that you may need to do every time you use iPython.

## 06. Evaluating code

Sometimes, you may have chunks of code that are put together
programmatically. If these pieces of code are put together as a
string, you can execute the result with the command
`eval("code_string")`. Any syntax errors within the code string are
reported as exceptions. By default, this code is executed within the
current session, using the current globals and locals
dictionaries. The `eval` command can also take two other optional
parameters, where you can provide a different set of dictionaries for
the globals and locals. If there is only one additional parameter,
then it is assumed to be a globals dictionary. You can optionally hand
in a code object that is created with the compile command instead of
the literal code string. The return value of this command is `None`.

```
ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import scipy
>>> mysin = 'scipy.sin(45.6)'
>>> eval(mysin)
0.9989000907450211
>>> 
```

## 07. Asserting values

At some point, there is the need to debug some piece of code we are
trying to write. One of the tools useful in this is the concept of an
assertion. The `assert` command takes a Python expression and checks
to see if it is true. If so, then execution continues as normal. If it
is not true, then an AssertionError is raised. Using this, you can
check to make sure that invariants within your code stay invariant. By
doing so, you can check assumptions made within your code. You can
optionally include a second parameter to the `assert` command. This
second parameter is Python expression that is executed if the
assertion fails. Usually, this is some type of detailed error message
that gets printed out. Or you may want to include cleanup code tries
to recover from the failed assertion.

## 08. Mapping functions

A common task that is done in modern programs is to map a given
computation to an entire list of elements. Python provides the command
`map` to do just this. The `map` command returns a list of the results
of the function applied to each element of an iterable object.  `map`
can actually take more than one function and more than one iterable
object.  If it is given more than one function, then a list of tuples
is returned with each element of the tuple containing the results from
each function.  If there is more than one iterable handed in, then map
assumes that the functions take more than one input parameter, so it
will take them from the given iterables. This has the implicit
assumption that the iterables are all of the same size, and that they
are all necessary as parameters for the given function.

## 09. Virtualenvs

Because of the potential complexity of the Python environment, it is
sometimes best to set up a clean environment within which to install
only the modules needed for a given project. In this case, you can use
the `virtualenv` command to initialize such an environment. If you
create a directory named `ENV`, then you can create a new environment
with the command `virtualenv ENV`. This will create the subdirectories
`bin`, `lib`, and `include`, and populate them with an initial
environment. You can then start using this new environment by sourcing
the script `ENV/bin/activate`, which will change several environment
variables, such as the PATH. When you are done, you can source the
script `ENV/bin/deactivate` to reset your shell's environment back to
its previous condition. In this way, you can have environments that
only have the modules you need for a given set of tasks.

```
ubuntu@myhost:~/the_fifty$ /opt/local/Python-
2.7.15/bin/virtualenv virtualenv1
New python executable in ~/the_fifty/virtualenv1/bin/python
Installing setuptools, pip, wheel...
done.
ubuntu@myhost:~/the_fifty$ . ./virtualenv1/bin/activate
(virtualenv1) ubuntu@myhost:~/the_fifty$ which python
~/the_fifty/virtualenv1/bin/python
(virtualenv1) ubuntu@myhost:~/the_fifty$ deactivate
```

## 10. Loops

While not strictly commands, everyone needs to know how to deal with
loops. The two main types of loops are a fixed number of iterations
loop (for) and a conditional loop (while). In a `for` loop, you
iterate over some sequence of values, pulling them off the list one at
a time and putting them in a temporary variable, You continue until
either you have processed every element or you have hit a `break`
command. In a `while` loop, you continue going through the loop as
long as some test expression evaluates to `True`. `while` loops can
also be exited early by using the `break` command, you can also skip
pieces of code within either loop by using a `continue` command to
selectively stop the current iteration and move on to the next one.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> for i in range(3):
...     print(i)
... 
0
1
2
>>> i=0
>>> while i<4:
...     print(i)
...     i = i + 1
... 
0
1
2
3
>>> 
```

## 11. Filtering

Where the command `map` returns a result for every element in an
iterable, `filter` only returns a result if the function returns a
`True` value. This means that you can create a new list of elements
where only the elements that satisfy some condition are used. As an
example, if your function checked that the values were numbers between
0 and 10, then it would create a new list with no negative numbers and
no numbers above 10. This could be accomplished with a `for` loop, but
this method is much cleaner. If the function provided to `filter` is
`None`, then it is assumed to be the identity function. This means
that only thos elements that evaluate to `True` are returned as part
of the new list. There are iterable versions of `filter` available in
the
[itertools](https://docs.python.org/2/library/itertools.html#itertools.ifilter)
module.

## 12. Reductions

In many calculations, one of the computations needed is to do a
reduction operation. This is where a list of values is given to be
reduced to a single value. In Python, the `reduce(function, iterable)`
is used to apply the reduction function to each pair of elements in
the list. For example, if the summation function is applied to the
list of the first five integers, the result of `((((1+2)+3)+4)+5)`.
Optionally, a third parameter may be given to act as an initial value.
It is loaded before any elements from the iterable, and is returned as
a default value if the iterable is empty. It is possible to use a
`lambda` function as the function parameter to reduce code bloat. Such
a function should be defined to take two input arguments.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> reduce(lambda a,b: a+b, range(3))
3
>>> reduce(lambda a,b: a+b, range(4))
6
>>> reduce(lambda a,b: a+b, range(5))
10
>>> reduce(lambda a,b: a*b, range(5))
0
>>> reduce(lambda a,b: a*b, range(1,5))
24
>>> 
```

## 13. How true is a list?

In some cases, an operation may result in a number of elements
collected within a list with value `True` or `False`. For example,
perhaps a series of resource checks were done with the results
accumulated into a list. The command `any(list)` checks to see whether
any of the elements in such a list are `True`. If the need arises to
check whether all elements of such a list are `True` the command
`all(list)` can be used. Both of these commands return `True` if the
relevant condition is satisfied, otherwise `False` is returned. These
commands do behave differently if the iterable object is empty,
however. The command `all` returns values of `True` if the iterable is
empty, whereas the command `any` returns `False` for an empty iterable
argument.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> my_bools = [True, True, False, False]
>>> all(my_bools)
False
>>> any(my_bools)
True
>>> my_list = [0, 1, 2, 3]
>>> all(my_list)
False
>>> any(my_list)
True
>>> my_list2 = ['a', 'b', 'c']
>>> all(my_list2)
True
>>> any(my_list2)
True
>>> empty_list = []
>>> all(empty_list)
True
>>> any(empty_list)
False
>>> 
```

## 14. Enumerating

At times we need to label the elements that reside within an iterable
object with their indices so that they can be processed at some point.
This could be done explicitly with a loop stepping through each of the
elements and building an enumerated list. The `enumerate` command does
this all in one line. It takes an iterable object and creates a list
of tuples as the result. Each tuple has the 0-based index of the
element, along with the element itself. You can optionally give some
other value as the start index by including it as an optional second
parameter. As an example, you could enumerate a list of names with the
command `list(enumerate(names, start=1))`. In this example, we decided
to start the indexing at 1 instead of 0.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> my_list = ['a', 'b', 'c']
>>> my_enums = enumerate(my_list)
>>> my_enums
<enumerate object at 0x7f07af344f00>
>>> list(my_enums)
[(0, 'a'), (1, 'b'), (2, 'c')]
>>> my_names = ['Seth', 'Garth', 'Fuerth']
>>> list(enumerate(my_names, start=1))
[(1, 'Seth'), (2, 'Garth'), (3, 'Fuerth')]
>>> 
```

## 15. Casting

Variables in Python don't have any type information, and so can be
used to store any type of object. The actual data, however, is of one
type or another. Many operators, like addition, assume that the input
values are of the same type. Often an operator is smart enough to make
the type of conversion that is needed. If there is the need to
explicitly convert some data from one type to another, there are a
class of functions that can be used to do this conversion process. The
ones most likely to be used are `abs`, `bin`, `bool`, `chr`,
`complex`, `float`, `hex`, `int`, `long`, `oct` and `str`. For the
number-based conversion functions, there is an order of prcedence
where some types are a subset of others. For example, integers are
"lower" than floats. When converting up, no changes in the ultimate
value should happen. When converting down, usually some amount of
information is lost. For example, when converting from float to
integer, Python truncates the number towards zero.

## 16. What is this?

Everything in Python is an object. It is possible to check what class
an object is an instance of with the command `isinstance(object,
class)`. This command returns a boolean value.

## 17. Is it a subclass?

The command `issubclass(class1, class2)` checks to see if `class1` is
a subclass of `class2`. If `class1` and `class2` are the same, this
command returns `True`.

## 18. Global objects

A dictionary of the global symbol table for the current module is
retrieved with the command `globals()`.

## 19. Local objects

An updated dictionary of the current local symbol table is obtained by
using the command `locals()`.

## 20. Variables

The command `vars(dict)` returns writeable elements for an object. If
`vars()` is invoked, it returns the same as `locals()`.

## 21. Making a global

A list of names can be interpreted as global references for an entire
code block with the command `globals <names>`.

```
def load_data():
    with open('blockchain.p', mode='rb') as f:
        data = pickle.loads(f.read())
        global blockchain, open_transactions
        blockchain = data['chain']
        open_transactions = data['otxns']
```

## 22. Nonlocals

Using Python 3 one can access names from the nearest enclosing scope
with the command `nonlocal <names>` and bind it to the local scope.

## 23. Raising an exception

When an error condition is encountered, code can use the `raise`
command to throw an exception to indicate the condition and interrupt
code flow. The exception raised can be of a specific type and can
include values.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> i = 0
>>> while i < 10:
...   print i
...   if i == 3:
...     raise(Exception)
...   i = i + 1
... 
0
1
2
3
Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
Exception
>>> 
```

## 24. Dealing with an exception

An exception thrown can be caught with using `try/except`. If the code
in the `try` block raises an exception, the code in the `except` block
gets run.

```
try:
    with open('wallet-{}.txt'.format(self.node_id), mode='r') as f:
        keys = f.readlines()
   
    self.__public_key = keys[0][:-1]
    self.__private_key = keys[1]
            
    return True
except (IOError, IndexError):
    print('Loading wallet failed!')        
return False
```

## 25. Static methods

It is possible to create a static method similar to what can be
defined statically in Java or C__ with the command `@staticmethod
function_name`.

```
@staticmethod    
def verify_transaction(transaction):
    if(transaction.sender == 'MINING'):
        return True
    public_key = RSA.importKey(to_binary(transaction.sender))
    verifer = PKCS1_v1_5.new(public_key)
    hash_ = SHA256.new((str(transaction.sender) + str(transaction.recipient) + str(transaction.amount)).encode('utf8'))
    return verifer.verify(hash_, to_binary(transaction.signature))
```

## 26. Ranges

The need may come for a list of numbers, perhaps to control a `for`
loop. The command `range()` can create an iterable list of
integers. With one parameter, it goes from 0 to the given number. An
optional start index can be provided, as well as a step size. Negative
step values count down.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> a = range(1,5)
>>> a
[1, 2, 3, 4]
>>> a[2]
3
>>> b = xrange(2,6)
>>> b
xrange(2, 6)
>>> b[2]
4
>>> b
xrange(2, 6)
>>> 
```

## 27. Xranges

One problem with ranges is that all of the elements need to be
calculated up front and stored in memory. The command `xrange()` takes
the same parameters and provides the same result, but only calculates
the next element when it is needed.

## 28. Iterators

Iteration is a very Pythonic way of doing things. For objects which
are not intrinsically iterable, you can use the command
`iter(object_name)` to essentially wrap the object and provide an
iterable interface for use with other functions and operators.

## 29. Sorted lists

The command `sorted(the_list)` can be used to sort the elements of a
list. Give it a custom comparison function, and for more complex
elements include a key function that pulls out a ranking property from
each element for comparison.

## 30. Summing items

Above, the general reduction function was described. A specific type
of reduction operation, summation, is common enough to warrant the
inclusion of a special case, the command
`sum(iterable_object)`. Include a second parameter to provide a
starting value.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> a = ['a', 'b', 'c']
>>> b = [1, 2, 3, 4]
>>> c = range(5)
>>> sum(a)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: unsupported operand type(s) for +: 'int' and 'str'
>>> sum(b)
10
>>> sum(c)
10
>>> 
```

## 31. With modules

The `with` command provides the ability to wrap a code block with
methods defined by a context manager. This can help clean up code and
make it easier to read what a given piece of code is supposed to be
doing months later. A classic example of using `with` is when dealing with files.
It is possible to use something like 

```
with open('myfile.txt', 'r') as f:
```

This will open the file and prepare it for reading. The file can then
be read in the code block with

```
data = f.read()
```

The best part of doing this is that the file handle will automatically
be closed when the block is exited, regardless of the reason. So, even
if the code block throws an exception, there is no need to worry about
closing the file as part of an exception handler. If a more
complicated `with` usage is needed, an explicit context manager class
can help out.

```
with open('blockchain.txt', mode='w') as f:
    f.write(json.dumps(blockchain))
    f.write('\n')
    f.write(json.dumps(open_transactions))
```

## 32. Printing

The most direct way of getting output to the user is with the `print`
command. This will send text out to the console window. When using
Python 2, there are a couple of ways of using the `print` command. The
most common way had been simply to call it as

```
print "Some text"
```

It is also possible to use `print` with the same syntax used for any
other function. So the above would be rendered in this fashion as

```
print("Some text")
```

This is the only form allowed in Python 3.

If the function syntax is used, extra parameters can be added to give
finer control over the output. For example, the parameter
`file=myfile.txt` may be added to get output of the `print` command
and dump this to the given text file. `print` will also accept any
object that can be represented as a string.

## 33. Memoryview

The need may arise to access the raw data of some object, perhaps as a
buffer of bytes. This data can be copied and put it into a bytearray,
for example. This entails using extra memory which might not be an
option for large objects. The command `memoryview(object_name)` wraps
the object argument and provides an interface to retrieve the raw
bytes. The interface gives access to these bytes one element at a
time. In many cases, elements are one byte in size. However, depending
on the object details, one could end up with elements that are larger
than that. The size of the elements can be looked up using the
`itemsize` property. Once the memory view is created, individual
elements can be accessed as one would get elements from a list
(mem_view[1], for example).

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> a = "Hello World"
>>> b = memoryview(a)
>>> b
<memory at 0x7f91fd0b03e0>
>>> list(b)
['H', 'e', 'l', 'l', 'o', ' ', 'W', 'o', 'r', 'l', 'd']
>>> b[5]
' '
>>> b[6]
'W'
>>> 
```

## 34. Files

When dealing with files, a file object must be created to interact
with the underlying storage. The `file` command takes a string with
the file name and location and creates a file object instance. The
file object methods can then be used such as `open`, `read` and
`close` to get data out of the file. The `readline` method can also be
used in file processing. There is an explicit `open` command to
simplify the process of opening a file. This command takes a string
containing the file name and an optional string parameter which
defines the access mode. The default is to open the file as read-only
(the 'r' access mode). The file can also be opened for writing with
'w' mode or appending with the 'a' mode. After `open` is called to
access the file, it returns a file object through which further
interaction is handled. This handle can then be used to read, write
and finally close the file.

## 35. Yielding

A function may need to yield the context of execution to some other
function. This case is enabled with generators. The preferred method
for a generator is that it will only calculate the next value when it
is requested through the method `next()`. The command `yield` saves
the current state of the generator function, and return execution
control to the calling function. In this way, the saved state of the
generator is reloaded and the generator picks up where it left off in
order to calculate the next requested value. In this way, memory is
used to store the minimum needed to calculate the next requested
value, instead of having to store all computed values in memory at one
time.

## 36. Weak references

The need may occur to have a reference to an object, but still be able
to destroy it if needed. A weak reference is one which can be ignored
by the garbage collector. If the only references left to an object are
weak references then the garbage collector is allowed to destroy that
object and reclaim the space for other uses. This is useful in cases
where you have caches or mappings of large datasets that don't
necessarily have to stay in memory. If an object that is weakly
referenced ends up being destroyed and one tries to access it, it will
appear as None. This condition can be tested for and the data can be
reloaded if necessary.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import weakref
>>> class myobj:
...   pass
... 
>>> obj1 = myobj()
>>> obj2 = weakref.ref(obj1)
>>> obj2 is obj1
False
>>> obj3 = obj2()
>>> obj3 is obj1
True
>>> del obj1
>>> obj3 is obj1
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'obj1' is not defined
>>> print obj2()
<__main__.myobj instance at 0x7f11c35267e8>
>>> 
```

## 37. Pickling data

There are a few different ways of serializing memory when the need
comes up to checkpoint results to disk. One of these is called
pickling. `pickle` is actually a complete module, not just a single
command. To store data to some media, the `dump` method is used to
write out the data. To reload this data at some later point in time,
the `load` method would be used to read the data in and unpickle
it. One issue with `pickle` is its speed, or lack of it. There is
another module, `cPickle`, that provides the same basic
functionality. But, since it is written in C, it can be as much as
1000 times faster. One thing to be aware of is that `pickle` does not
stora any class information for an object, but only its instance
information.  This means that when you unpickle the object, it may
have different methods and attributes if the class definition has
changed in the interim.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25)
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import pickle
>>> data1 = ['a', 'b', 'c']
>>> output1 = open('mypickle.dat', 'wb')
>>> pickle.dump(data1, output1)
>>> output1.close()
>>> input1 = open('mypickle.dat', 'rb')
>>> data2 = pickle.load(input1)
>>> data1
['a', 'b', 'c']
>>> data2
['a', 'b', 'c']
>>> 
```

## 38. Shelving data

While pickling allows for saving and reloading data, there is another
option when more structured object permanance is needed in a Python
session. With the `shelve` module, an object store may be created that
can store essentially anything that can be pickled. The backend of the
storage medium can be handled by one of several systems, such as dbm
or gdbm. One the shelf is opened, it can be read or written using
key-value pairs. The store needs to be explicitly closed when storage
operations are completed to synchronize state to shelf's backing
storage. Because of the way the data may be stored in the backing
database, it is best not to open the relevant files outside of the
`shelve` module in Python. When the shelf is opened with writeback set
to `True`, the `sync()` method can be called explicitly to immediately
write out cached changes.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> import shelve
>>> myshelf = shelve.open('myshelf.dat')
>>> myshelf['1'] = 'a'
>>> myshelf['2'] = 'b'
>>> myshelf.keys()
['2', '1']
>>> myshelf.close()
>>> myshelf.keys()
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "/opt/local/Python-2.7.15/lib/python2.7/shelve.py", line 101, in keys
    return self.dict.keys()
  File "/opt/local/Python-2.7.15/lib/python2.7/shelve.py", line 79, in closed
    raise ValueError('invalid operation on closed shelf')
ValueError: invalid operation on closed shelf
>>> 
```

## 39. Threads

It is possible to run multiple threads of execution within Python. The
`thread()` command can create a new thread of execution when
needed. It follows the same techniques as those for POSIX
threads. When first creating a thread, it is required to give a
function name, along with whatever parameters this function needs. One
thing to keep in mind is that these threads behave just like POSIX
threads. This means that the developer has responsibilities of
handling mutex locks (with the methods `acquire` and `release`), as
well as create the original mutexes with the method
`allocate_lock`. When the operation is done, the `exit` method must be
called on the thread to ensure that it is properly cleaned up and no
resources get left behind. Fine-grained control over threads are
permitted which allow settings such as the stack size for new threads.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> my_func = lambda x: x * x
>>> import thread
>>> my_thread = thread.start_new_thread(my_func, (1,))
>>> my_thread
139898042062592
>>> 
```

## 40. Inputting data

The need may come to collect input from an end user. The command
`input()` can take a prompt string to display to the user, and then
wait for the user to type a response. Once the user is done typing and
hits the enter key, the text is returned to the program. If the
`readline` module was loaded before calling input, enhanced line
editing and history functionality is enabled. This command passes the
text through eval first, and doing so may cause uncaught errors. To
prevent such occurrence, the `raw_input()` may be used. This command
simply returns the unchanged string as input by the user. Again, the
readline module can be used for enhanced line editing.

## 41. Internal variables

For those with experience programming in other languages, there is a
concept of having certain variables or methods be only available
internally within an object. In Python, there is no such concept. All
elements of an object are accessible. There is a style rule, however,
that can mimic this type of behavior. Any names that start with an
underscore are expected to be treated as if they were internal names
and to be kept as private to the object. They are not hidden, however,
and there is no explicit protection for these variables or methods. It
is up to the programmer to honor the intention of the author of the
class and not alter any of these internal names. One is free to make
these types of changes if it becomes necessary to do so however.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> class my_class:
...   _internal_num = 23
...   _internal_string = "Hello Str"
...   def _internal_func():
...     print "How did you find me?"
...   def regular_func():
...     print "You are allowed here"
... 
>>> my_obj = my_class()
>>> my_obj._internal_num
23
>>> 
```

## 42. Comparing objects

There are several ways to compare objects within Python, with several
caveats. The first is that two things can be tested between objects:
equality and identity. For testing identity, two identifiers are
checked to see if they refer to the same object. This can be done with
the command `cmp(obj1,obj2)`. Identity can also be tested using the
`is` keyword. For example, `obj1 is obj2`. For testing equality, the
values in the objects are checked to see if they are the same. This
test is handled by the `==` operator, as in `obj1 == obj2`. Testing
for equality can become more complex for more complicated or deeply
nested objects.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> str1 = 'Hello World'
>>> str2 = str1
>>> str3 = 'Hello World'
>>> str1 == str2
True
>>> str1 == str3
True
>>> cmp(str1, str2)
0
>>> cmp(str1, str3)
0
>>> str1 is str2
True
>>> str1 is str3
False
>>> 
```

## 43. Slices

While not truly a command, slices are too important a concept not to
mention in this list of essential commands. Indexing elements in data
structures - like lists - is one of the most common things done in
Python.  A single element can be selected by giving a single index
value. More interestingly, a range of elements can be selected by
giving a start and an end index, separated by a colon. This gets
returned as a new list that can be saved to a new variable name. A
step size can be used to skip some number of elements if
desired. Every odd element of a list can be selected from list `a`
with the slice `a[1::2]`. This starts at index 1 and continues to the
end, and steps through the list values 2 index steps at a time. Slices
can be given negative index values. If so, then iteration starts from
the end of the list and counts backwards.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> a = "Hello World"
>>> a[1:3]
'el'
>>> a[:3]
'Hel'
>>> a[::2]
'HloWrd'
>>> a[1::2]
'el ol'
>>> a[-1::2]
'd'
>>> 
```

## 44. Lambda expressions

Since objects, and the names that point to them, are truly different
things then objects can be created that have no references to
them. One example of this is the lambda expression. With this, an
anonymous function can be created. This allows for the use of
functional programming techniques with Python. The format is the
keyword `lambda`, followed by a parameter list, then a colon and the
function code. For example, one could build a function to square a
number with `lambda x: x * x`. This implies it is also possible to
programmatically create new functions and return them to the calling
code. With this capability, function generators can be created to
build self-modifying programs. The only limitation is that they are
limited to a single expression, so it cannot be used to generate very
complex functions.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> sqr1 = lambda x: x* x
>>> sqr1(10)
100
>>> sqr1(6)
36
>>> def gen_func(x):
...   return lambda y: y**x
... 
>>> cubic = gen_func(3)
>>> cubic(2)
8
>>> 
```

## 45. Compiling code objects

Python is an interpreted language, which means that the source code of
programs gets compiled to a bytecode format. This bytecode then gets
fed into the actual Python engine to step through the
instructions. Within a program, it is possible to take control over
the process of converting code to bytecode and running the
results. One possibility is to build a new kind of REPL. The command
`compile()` takes a string object that contains a collection of Python
code, and returns an object that represents a bytecode translation of
this code. This new object can then be handed in to either `eval()` or
`exec()` to be executed. The `mode=` parameter can be used to tell the
compiler what kind of code is being compiled. The `single` mode is a
single statement, `eval` is a single expression and `exec` is a whole
code block.

## 46. __init__ method

On creating a new class, a private intialization method can be
included that gets called whenever a new instance of the class is
created. This method is useful when new data needs to be loaded in to
a newly created object.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> class MyClass:
...   def __init__(self):
...     print "Created"
... 
>>> myobj = MyClass()
Created
>>> 
```

## 47. __del__ method

When an instance object is about to be destroyed, the `__del__` method
is called. This gives the chance to do any kind of cleanup that may be
required. This might involve closing files, or closing network
connections. After this code is completed, the object is finally
destroyed and resources are freed.

## 48. Exiting your program

There are two pseudo-commands available to exit from the Python
interpreter: `exit()` and `quit()`. They both take an optional
parameter which sets the exit code for the process. To exit from a
script, it is better to use the `exit` function for the sys module:

```
sys.exit(exit_code)
```

## 49. Return values

Functions may need to return some value to the calling
function. Because essentially no name has a type, this includes
functions. So functions can use the `return` command to return any
object to the caller.

## 50. String concatenation

This item closes where most lists begin: with string
concatenation. The easiest way to build up strings is to use the `+`
operator. To include other items, such as numbers, the `str()` casting
function can be used to convert these to string objects.

```
(fiftyenv) ubuntu@myhost:~/the_fifty$ python
Python 2.7.15 (default, Dec 27 2018, 04:00:25) 
[GCC 5.4.0 20160609] on linux2
Type "help", "copyright", "credits" or "license" for more information.
>>> str1 = "Bon"
>>> str2 = str1 + "jour"
>>> str3 = "et Bienvenue"
>>> str1 + str2 + str3
'BonBonjouret Bienvenue'
>>> str1 + str(34)
'Bon34'
>>> 
```