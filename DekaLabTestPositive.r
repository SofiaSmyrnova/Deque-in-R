library("testthat")

test_that("push_front adds element to the beginning (menu 1)", {
  x <- new_deka()
  push_back(x, "A")
  push_front(x, "B")
  expect_equal(peek_front(x), "B")
  expect_equal(peek_back(x), "A")
  expect_equal(deka_size(x), 2L)
})

test_that("push_back adds element to the end (menu 2)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  expect_equal(peek_back(x), "B")
  expect_equal(peek_front(x), "A")
  expect_equal(deka_size(x), 2L)
})

test_that("pop_front removes and returns the first (menu 3)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  expect_equal(pop_front(x), "A")
  expect_equal(peek_front(x), "B")
  expect_equal(deka_size(x), 1L)
})

test_that("pop_back removes and returns the last (menu 4)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  expect_equal(pop_back(x), "B")
  expect_equal(peek_back(x), "A")
  expect_equal(deka_size(x), 1L)
})

test_that("peek_front reads the first without removing (menu 5)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  expect_equal(peek_front(x), "A")
  expect_equal(deka_size(x), 2L)
})

test_that("peek_back reads the last without removing (menu 6)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  expect_equal(peek_back(x), "B")
  expect_equal(deka_size(x), 2L)
})

test_that("swap_ends swaps first and last (menu 7)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  push_back(x, "C")
  push_back(x, "D")
  swap_ends(x)
  expect_equal(peek_front(x), "D")
  expect_equal(peek_back(x), "A")
  expect_equal(x$head$nxt$value, "B")
  expect_equal(x$head$nxt$nxt$value, "C")
  expect_equal(deka_size(x), 4L)
})

test_that("is_empty: TRUE when new, FALSE when non-empty (menu 8)", {
  x <- new_deka()
  expect_true(is_empty(x))
  push_back(x, "A")
  expect_false(is_empty(x))
})

test_that("deka_size counts the elements (menu 9)", {
  x <- new_deka()
  expect_equal(deka_size(x), 0L)
  push_back(x, "A")
  push_back(x, "B")
  push_back(x, "C")
  expect_equal(deka_size(x), 3L)
})

test_that("reverse flips the order (menu 10)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  push_back(x, "C")
  reverse(x)
  expect_equal(peek_front(x), "A")
  expect_equal(peek_back(x), "C")
  expect_equal(deka_size(x), 3L)
})

test_that("contains finds present elements (menu 11)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  push_back(x, "C")
  expect_true(contains(x, "A"))
  expect_true(contains(x, "B"))
  expect_true(contains(x, "C"))
})

test_that("clear empties the deque (menu 12)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  push_back(x, "C")
  clear(x)
  expect_true(is_empty(x))
  expect_equal(deka_size(x), 0L)
})

test_that("print_deka outputs the elements (menu 13)", {
  x <- new_deka()
  push_back(x, "A")
  push_back(x, "B")
  push_back(x, "C")
  expect_output(print_deka(x), "A")
  expect_output(print_deka(x), "B")
  expect_output(print_deka(x), "C")
})
