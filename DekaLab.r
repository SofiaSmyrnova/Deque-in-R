create_node <- function(value) {
  node <- new.env()
  node$value <- value
  node$prev <- NULL
  node$nxt <- NULL
  node
}

new_deka <- function() {
  x <- new.env()
  x$head <- NULL
  x$tail <- NULL
  x$size <- 0L
  x
}

is_empty <- function(x) x$size == 0L
deka_size <- function(x) x$size

push_front <- function(x, value) {
  node <- create_node(value)
  if (is_empty(x)) {
    x$head <- node
    x$tail <- node
  } else {
    node$nxt <- x$head
    x$head$prev <- node
    x$head <- node
  }
  x$size <- x$size + 1L
  invisible(x)
}
print_deka <- function(x) {
  if (is_empty(x)) {
    cat("Empty\n")
    return(invisible(x))
  }
  node <- x$head
  while (!is.null(node)) {
    cat(as.character(node$value), "")
    node <- node$nxt
  }
  cat("\n")
  invisible(x)
}

push_back <- function(x, value) {
  node <- create_node(value)
  if (is_empty(x)) {
    x$head <- node
    x$tail <- node
  } else {
    node$prev <- x$tail
    x$tail$nxt <- node
    x$tail <- node
  }
  x$size <- x$size + 1L
  invisible(x)
}

pop_front <- function(x) {
  if (is_empty(x)) stop("deka is empty")
  node <- x$head
  val <- node$value
  x$head <- node$nxt
  if (is.null(x$head)) {
    x$tail <- NULL
  } else {
    x$head$prev <- NULL
  }
  x$size <- x$size - 1L
  val
}

pop_back <- function(x) {
  if (is_empty(x)) stop("deka is empty") # do we need STOP?
  node <- x$tail
  val <- node$value
  x$tail <- node$prev
  if (is.null(x$tail)) {
    x$head <- NULL
  } else {
    x$tail$nxt <- NULL
  }
  x$size <- x$size - 1L
  val
}

peek_front <- function(x) {
  if (is_empty(x)) stop("deque is empty")
  x$head$value
}

peek_back <- function(x) {
  if (is_empty(x)) stop("deque is empty")
  x$tail$value
}

contains <- function(x, value) {
  node <- x$head
  while (!is.null(node)) {
    if (identical(node$value, value)) {
      return(TRUE)
    }
    node <- node$nxt
  }
  FALSE
}

clear <- function(x) {
  x$head <- NULL
  x$tail <- NULL
  x$size <- 0L
  invisible(x)
}

reverse <- function(x) {
  node <- x$head
  while (!is.null(node)) {
    nxt_node <- node$nxt
    tmp <- node$prev
    node$prev <- node$nxt
    node$nxt <- tmp
    node <- nxt_node
  }
  tmp <- x$head
  x$head <- x$tail
  x$tail <- tmp
  invisible(x)
}

swap_ends <- function(x) {
  if (x$size < 2L) {
    return(invisible(x))
  }
  tmp <- x$head$value
  x$head$value <- x$tail$value
  x$tail$value <- tmp
  invisible(x)
}

run_menu <- function() {
  x <- new_deka()
  repeat {
    cat(" 1) Add to beginning\n")
    cat(" 2) Add to end\n")
    cat(" 3) Remove the first\n")
    cat(" 4) Remove the last\n")
    cat(" 5) Read the first\n")
    cat(" 6) Read the last\n")
    cat(" 7) Swap first and last\n")
    cat(" 8) Emptiness check\n")
    cat(" 9) Size\n")
    cat("10) Reverse\n")
    cat("11) Does the element belongs to\n")
    cat("12) Clear\n")
    cat("13) Print the deque\n")
    cat(" 0) Exit\n")
    choice <- readline("Your choice: ")

    if (choice == "0") {
      cat("Exit\n")
      break
    } else if (choice == "1") {
      v <- readline("Value: ")
      push_front(x, v)
      print_deka(x)
    } else if (choice == "2") {
      v <- readline("Value: ")
      push_back(x, v)
      print_deka(x)
    } else if (choice == "3") {
      if (is_empty(x)) {
        cat("Deque is empty\n")
      } else {
        cat("Removed:", pop_front(x), "\n")
      }
      
      print_deka(x)
    } else if (choice == "4") {
      if (is_empty(x)) {
        cat("Deque is empty\n")
      } else {
        cat("Removed:", pop_back(x), "\n")
      }
      print_deka(x)
    } else if (choice == "5") {
      if (is_empty(x)) {
        cat("Deque is empty\n")
      } else {
        cat("First:", peek_front(x), "\n")
      }
    } else if (choice == "6") {
      if (is_empty(x)) {
        cat("Deque is empty\n")
      } else {
        cat("Last:", peek_back(x), "\n")
      }
    } else if (choice == "7") {
      swap_ends(x)
      print_deka(x)
    } else if (choice == "8") {
      if (is_empty(x)) cat("Deque is empty\n") else cat("Deque isn't empty\n")
    } else if (choice == "9") {
      cat("Size:", deka_size(x), "\n")
    } else if (choice == "10") {
      reverse(x)
      print_deka(x)
    } else if (choice == "11") {
      v <- readline("Search gor: ")
      if (contains(x, v)) cat("Belongs to\n") else cat("Doesn't belong to\n")
    } else if (choice == "12") {
      clear(xd)
      cat("Deque is cleared\n")
    } else if (choice == "13") {
      print_deka(x)
    } else {
      cat("Unknown request\n")
    }
  }
}
