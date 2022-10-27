1.
b) `output_pointer` keeps track of what is the next storage slot that will be
    printed using serialize_word


2. 

```
%builtins output

// Import the serialize_word() function.
from starkware.cairo.common.serialize import serialize_word

func square(n: felt) -> (r: felt) {
    return(r = n * n);
}

func main{output_ptr: felt*}() {
    tempvar number = 3;
    let (result) = square(number);
    
    serialize_word(number);
    serialize_word(result);
    return ();
}

```

