Brandon Lerner
lerner.b@husky.neu.edu

1) What language did you write your implementation in?

Python

2) Does your code require building before it can be executed?

Nope, all set with execute permissions!

3) Describe in one paragraph or less the algorithm you implemented.

The algorithm I implemented created a 2D array for the N number of variables, created a graph object that stores that, and adds edges when two vertexes are equal.
If any two vertexes are not equal, it adds it to a list to check through DFS if the two are connected components.
For each != pair, it checks for connected components, and returns with the proper answer given it is / not.

4) Does your implementation pass all of the given test cases? 

All tests pass, tested on darktower 

5) Approximately how long does your solution take on very large inputs? (2.5 million variables, 2.5 million constraints).

~ 8 second running time on the largest tests on darktower

6) What is the worst case order notation run time of your implementation? Depending on what sort of data structure you implemented, it may be appropriate to do some amortized analysis here.

Worst case is O(n + mlogn) if it needs to run through every single inequality due to DFS.
