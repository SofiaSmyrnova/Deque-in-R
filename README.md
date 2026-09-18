# Doubly-Linked Deque in R

A **deque** (double-ended queue) implemented in R as a **doubly-linked list**,
built on `environment` objects to get true reference (pointer-like) semantics.
All operations on both ends run in **O(1)**.

The project includes the data structure itself, an interactive text menu for
manual checking, and a `testthat` suite (positive and negative cases).

---

## What a deque is

A **deque** is a linear structure that allows adding and removing elements at
**both ends** — the front and the back. It generalises two familiar structures:

- a **stack** (LIFO) uses only one end;
- a **queue** (FIFO) adds at one end and removes at the other;
- a **deque** does both at either end.

The defining requirement is that all four end operations — push front, push
back, pop front, pop back — must be **fast (O(1))**. That requirement is exactly
what dictates the implementation below.

### Why a *doubly*-linked list

To remove the **last** element in O(1), a node must know its **previous**
neighbour — otherwise you would have to walk the whole list from the front to
find it, which is O(n). A singly-linked list cannot do this. A doubly-linked
list gives every node two links:

```
prev  <-  [ value ]  ->  nxt
```

- `nxt` points to the next node (towards the back),
- `prev` points to the previous node (towards the front).

With links in both directions, removal and insertion at either end are constant
time, and reversing the list is a clean swap of the two link fields on each node.

A plain array/vector is not used on purpose: it has a fixed size and costs O(n)
to insert or delete at the front (all elements must shift). The linked structure
grows dynamically and keeps every end operation O(1).

---

## Element references in R: why `environment`, not `list`

This is the part specific to R, and the reason the implementation looks the way
it does.

R uses **copy-on-modify**: when you change an object, R makes a copy. Two
variables that seem to share data quietly diverge on the first edit:

```r
a <- list(value = 1)
b <- a
b$value <- 99
a$value        # still 1 — the list was copied
```

If nodes behaved like this, a linked list would be impossible: reassign one
node's `nxt` and the neighbours would still point at a stale copy — the chain
would fall apart.

The one thing in base R with **reference semantics** (assigned and passed by
reference, never copied) is the `environment`. It behaves like a pointer:

```r
e1 <- new.env()
e1$value <- 1
e2 <- e1        # NOT a copy — the same environment
e2$value <- 99
e1$value        # 99 — the change is visible through both names
```

So every **node** is an `environment` with three fields — `value`, `prev`,
`nxt` — and the **deque** itself is an `environment` holding `head`, `tail`, and
`size`. Because environments are references, functions can mutate the structure
in place instead of returning rebuilt copies, and two nodes can genuinely link
to each other.

Memory is reclaimed by R's **garbage collector**: `clear()` simply drops the
references (`head`/`tail` set to `NULL`), the nodes become unreachable, and the
GC frees them. No manual `free`/`delete` is required, unlike in C or C++.

---

## Operations

| Operation      | Function       | Complexity | Description                                   |
|----------------|----------------|-----------|-----------------------------------------------|
| push front     | `push_front`   | O(1)      | add an element at the beginning               |
| push back      | `push_back`    | O(1)      | add an element at the end                     |
| pop front      | `pop_front`    | O(1)      | remove and return the first element           |
| pop back       | `pop_back`     | O(1)      | remove and return the last element            |
| peek front     | `peek_front`   | O(1)      | read the first element without removing it    |
| peek back      | `peek_back`    | O(1)      | read the last element without removing it     |
| swap ends      | `swap_ends`    | O(1)      | swap the first and last elements              |
| is empty       | `is_empty`     | O(1)      | check whether the deque is empty              |
| size           | `deka_size`    | O(1)      | number of elements                            |
| reverse        | `reverse`      | O(n)      | reverse the order of all elements             |
| contains       | `contains`     | O(n)      | check whether a given element is present      |
| clear          | `clear`        | O(1)      | remove all elements                           |
| print          | `print_deka`   | O(n)      | print the deque from front to back            |

`pop_*` and `peek_*` raise an error (`stop()`) on an empty deque instead of
failing silently — this is what the negative tests verify.

---

## Project structure

```
DekaLab.r                 # the deque: node + deque constructors, all operations, interactive menu
DekaLabTestPositive.r     # positive tests — each operation works on valid input
DekaLabTestNegative.r     # negative tests — errors on empty deque, edge cases (empty / single element)
```

---

## Usage

Load the implementation and use it directly:

```r
source("DekaLab.r")

d <- new_deka()
push_back(d, "A")
push_back(d, "B")
push_front(d, "X")
print_deka(d)        # X A B

reverse(d)
print_deka(d)        # B A X

peek_front(d)        # "B"
deka_size(d)         # 3
contains(d, "A")     # TRUE
```

### Interactive menu

For manual, arbitrary-order checking, run the built-in menu:

```r
source("DekaLab.r")
run_menu()
```

It prints a numbered list of every operation and applies the one you choose.
(The menu reads keyboard input via `readline`, so run it in an interactive R
console / RStudio.)

---

## Running the tests

The suite uses the [`testthat`](https://testthat.r-lib.org/) package:

```r
install.packages("testthat")   # once
```

Then load the functions and run the test files:

```r
library(testthat)
source("DekaLab.r")

test_file("DekaLabTestPositive.r")
test_file("DekaLabTestNegative.r")
```

A successful run reports something like `[ FAIL 0 | PASS 34 ]`.

The tests cover: basic functionality of every operation, boundary cases (empty
deque, single element, removing the last remaining element), error handling on
an empty deque, and preservation of the doubly-linked invariant.

---

## Notes

- Written as a data-structures lab: implement a deque with a **dynamic
  (linked) approach**, provide an interface for checking operations in any
  order, and cover it with tests.
- The interesting design decision is using `environment` for reference
  semantics — the natural way to build a real linked structure in R without
  fighting copy-on-modify.
