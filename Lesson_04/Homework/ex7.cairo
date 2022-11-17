%lang starknet
from starkware.cairo.common.bitwise import bitwise_and, bitwise_xor
from starkware.cairo.common.cairo_builtins import BitwiseBuiltin
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.math import unsigned_div_rem

// Using binary operations return:
// - 1 when pattern of bits is 01010101 from LSB up to MSB 1, but accounts for trailing zeros
// - 0 otherwise

// 000000101010101 PASS
// 010101010101011 FAIL

func pattern{bitwise_ptr: BitwiseBuiltin*, range_check_ptr}(
    n: felt, idx: felt, exp: felt, broken_chain: felt
) -> (true: felt) {
    if (exp == 252) {
      return (true=1);
    }
    
    let (shift_n, last_bit) = unsigned_div_rem(n, 2);
    
    if (exp == 0) {
        let (xor_last_bit) = bitwise_xor(last_bit, 1);
        let (next) = pattern(shift_n, xor_last_bit, exp+1, 0);
        return (true=next);
    }

    let (xor_idx) = bitwise_xor(idx, 1);
    
    // %{ print(ids.last_bit, ids.idx, ids.exp, ids.broken_chain, ids.n) %}
    if (broken_chain != 0) {
        if (last_bit == 0) {
            let (next) = pattern(shift_n, xor_idx, exp+1, broken_chain);
            return (true = next);
        }
        return (true=0);
    }
    if (last_bit == idx) {
        let (next) = pattern(shift_n, xor_idx, exp+1, 0);
        return (true=next);
    }
    if (last_bit == 1) {
        return (true=0);
    }
    let (next) = pattern(shift_n, xor_idx, exp+1, 1);
    return (true = next);
}