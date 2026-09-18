library("testthat")

test_that("pop_front on empty deque throws error (menu 3)", {
  x <- new_deka()
  expect_error(pop_front(x)) 
})

test_that("pop_back on empty deque throws error  (menu 4)", {
  x <- new_deka()
  expect_error(pop_back(x)) 
})

test_that("peek_front on empty deque throws error (menu 5)", {
  x <- new_deka()
  expect_error(peek_front(x))
})

test_that("peek_back on empty deque throws error (menu 6)", {
  x <- new_deka()
  expect_error(peek_back(x))
})

test_that("swap_ends doesn't crash on empty/single (menu 7)", {
  expect_error(swap_ends(new_deka()), NA)
  x <- new_deka(); push_back(x, "A")
  expect_error(swap_ends(x), NA)          
  expect_equal(peek_front(x), "A")        
})

test_that("reverse doesn't crash on empty/single (menu 10)", {
  expect_error(reverse(new_deka()), NA)     
  x <- new_deka(); push_back(x, "A")
  expect_error(reverse(x), NA)              
  expect_equal(peek_front(x), "A")         
})