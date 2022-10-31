from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin, HashBuiltin

// Implement a function that sums even numbers from the provided array
func sum_even{bitwise_ptr: BitwiseBuiltin*}(arr_len: felt, arr: felt*, run: felt, idx: felt) -> (
    sum: felt
) {
    if (arr_len == 0) {
      return (sum=0);
    }
    let (next_sum) = sum_even(arr_len - 1, arr + 1, run, idx);
    let x = [arr];
    let (last_bit) = bitwise_and(x, 0x1);
    //%{ print(ids.last_bit) %}
    if (last_bit == 1) {
      return (sum=next_sum);
    }
    let res = x + next_sum;
    return (sum=res);
}