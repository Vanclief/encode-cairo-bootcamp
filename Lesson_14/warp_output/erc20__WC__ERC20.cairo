%lang starknet


from warplib.memory import wm_alloc, wm_write_256, wm_dyn_array_length
from starkware.cairo.common.uint256 import Uint256, uint256_sub, uint256_lt, uint256_eq, uint256_add
from starkware.cairo.common.dict import dict_write, dict_read
from warplib.maths.utils import narrow_safe
from warplib.maths.int_conversions import warp_uint256
from starkware.cairo.common.alloc import alloc
from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from starkware.starknet.common.syscalls import get_caller_address
from warplib.maths.sub import warp_sub256
from warplib.maths.add import warp_add256
from starkware.cairo.common.dict_access import DictAccess
from starkware.cairo.common.default_dict import default_dict_new, default_dict_finalize


struct cd_dynarray_felt{
     len : felt ,
     ptr : felt*,
}

func WM0_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt, e7: felt, e8: felt, e9: felt, e10: felt, e11: felt, e12: felt, e13: felt, e14: felt, e15: felt, e16: felt, e17: felt, e18: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x15, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x13, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
dict_write{dict_ptr=warp_memory}(start + 9, e7);
dict_write{dict_ptr=warp_memory}(start + 10, e8);
dict_write{dict_ptr=warp_memory}(start + 11, e9);
dict_write{dict_ptr=warp_memory}(start + 12, e10);
dict_write{dict_ptr=warp_memory}(start + 13, e11);
dict_write{dict_ptr=warp_memory}(start + 14, e12);
dict_write{dict_ptr=warp_memory}(start + 15, e13);
dict_write{dict_ptr=warp_memory}(start + 16, e14);
dict_write{dict_ptr=warp_memory}(start + 17, e15);
dict_write{dict_ptr=warp_memory}(start + 18, e16);
dict_write{dict_ptr=warp_memory}(start + 19, e17);
dict_write{dict_ptr=warp_memory}(start + 20, e18);
    return (start,);
}

func WM1_d_arr{range_check_ptr, warp_memory: DictAccess*}(e0: felt, e1: felt, e2: felt, e3: felt, e4: felt, e5: felt, e6: felt) -> (loc: felt){
    alloc_locals;
    let (start) = wm_alloc(Uint256(0x9, 0x0));
wm_write_256{warp_memory=warp_memory}(start, Uint256(0x7, 0x0));
dict_write{dict_ptr=warp_memory}(start + 2, e0);
dict_write{dict_ptr=warp_memory}(start + 3, e1);
dict_write{dict_ptr=warp_memory}(start + 4, e2);
dict_write{dict_ptr=warp_memory}(start + 5, e3);
dict_write{dict_ptr=warp_memory}(start + 6, e4);
dict_write{dict_ptr=warp_memory}(start + 7, e5);
dict_write{dict_ptr=warp_memory}(start + 8, e6);
    return (start,);
}

func wm_to_storage0_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(storage_name: felt, mem_loc : felt, length: Uint256) -> (){
    alloc_locals;
    if (length.low == 0 and length.high == 0){
        return ();
    }
    let (index) = uint256_sub(length, Uint256(1,0));
    let (storage_loc) = WARP_DARRAY0_felt.read(storage_name, index);
    let mem_loc = mem_loc - 1;
    if (storage_loc == 0){
        let (storage_loc) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(storage_loc + 1);
        WARP_DARRAY0_felt.write(storage_name, index, storage_loc);
    let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage0_elem(storage_name, mem_loc, index);
    }else{
    let (copy) = dict_read{dict_ptr=warp_memory}(mem_loc);
    WARP_STORAGE.write(storage_loc, copy);
    return wm_to_storage0_elem(storage_name, mem_loc, index);
    }
}
func wm_to_storage0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}(loc : felt, mem_loc : felt) -> (loc : felt){
    alloc_locals;
    let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
    let (mem_length) = wm_dyn_array_length(mem_loc);
    WARP_DARRAY0_felt_LENGTH.write(loc, mem_length);
    let (narrowedLength) = narrow_safe(mem_length);
    wm_to_storage0_elem(loc, mem_loc + 2 + 1 * narrowedLength, mem_length);
    let (lesser) = uint256_lt(mem_length, length);
    if (lesser == 1){
       WS0_DYNAMIC_ARRAY_DELETE_elem(loc, mem_length, length);
       return (loc,);
    }else{
       return (loc,);
    }
}

func WS0_DYNAMIC_ARRAY_DELETE_elem{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt, index : Uint256, length : Uint256){
     alloc_locals;
     let (stop) = uint256_eq(index, length);
     if (stop == 1){
        return ();
     }
     let (elem_loc) = WARP_DARRAY0_felt.read(loc, index);
    WS1_DELETE(elem_loc);
     let (next_index, _) = uint256_add(index, Uint256(0x1, 0x0));
     return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, next_index, length);
}
func WS0_DYNAMIC_ARRAY_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt){
   alloc_locals;
   let (length) = WARP_DARRAY0_felt_LENGTH.read(loc);
   WARP_DARRAY0_felt_LENGTH.write(loc, Uint256(0x0, 0x0));
   return WS0_DYNAMIC_ARRAY_DELETE_elem(loc, Uint256(0x0, 0x0), length);
}

func WS1_DELETE{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt){
    WARP_STORAGE.write(loc, 0);
    return ();
}

func WS0_READ_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = readId(loc);
    return (read0,);
}

func WS1_READ_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: Uint256){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0,high=read1),);
}

func WS2_READ_felt{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) ->(val: felt){
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    return (read0,);
}

func ws_dynamic_array_to_calldata0_write{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(
   loc : felt,
   index : felt,
   len : felt,
   ptr : felt*) -> (ptr : felt*){
   alloc_locals;
   if (len == index){
       return (ptr,);
   }
   let (index_uint256) = warp_uint256(index);
   let (elem_loc) = WARP_DARRAY0_felt.read(loc, index_uint256);
   let (elem) = WS2_READ_felt(elem_loc);
   assert ptr[index] = elem;
   return ws_dynamic_array_to_calldata0_write(loc, index + 1, len, ptr);
}
func ws_dynamic_array_to_calldata0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc : felt) -> (dyn_array_struct : cd_dynarray_felt){
   alloc_locals;
   let (len_uint256) = WARP_DARRAY0_felt_LENGTH.read(loc);
   let len = len_uint256.low + len_uint256.high*128;
   let (ptr : felt*) = alloc();
   let (ptr : felt*) = ws_dynamic_array_to_calldata0_write(loc, 0, len, ptr);
   let dyn_array_struct = cd_dynarray_felt(len, ptr);
   return (dyn_array_struct,);
}

func WS_WRITE0{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: Uint256) -> (res: Uint256){
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}

func WS_WRITE1{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt, value: felt) -> (res: felt){
    WARP_STORAGE.write(loc, value);
    return (value,);
}

@storage_var
func WARP_DARRAY0_felt(name: felt, index: Uint256) -> (resLoc : felt){
}
@storage_var
func WARP_DARRAY0_felt_LENGTH(name: felt) -> (index: Uint256){
}

@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc : felt){
}
func WS0_INDEX_felt_to_Uint256{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_MAPPING0.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}

@storage_var
func WARP_MAPPING1(name: felt, index: felt) -> (resLoc : felt){
}
func WS1_INDEX_felt_to_warp_id{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(name: felt, index: felt) -> (res: felt){
    alloc_locals;
    let (existing) = WARP_MAPPING1.read(name, index);
    if (existing == 0){
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 1);
        WARP_MAPPING1.write(name, index, used);
        return (used,);
    }else{
        return (existing,);
    }
}


// Contract Def ERC20


@event
func Approval_8c5be1e5(__warp_usrid_19_owner : felt, __warp_usrid_20_spender : felt, __warp_usrid_21_value : Uint256){
}


@event
func Transfer_ddf252ad(__warp_usrid_16_from : felt, __warp_usrid_17_to : felt, __warp_usrid_18_value : Uint256){
}

@storage_var
func WARP_STORAGE(index: felt) -> (val: felt){
}
@storage_var
func WARP_USED_STORAGE() -> (val: felt){
}
@storage_var
func WARP_NAMEGEN() -> (name: felt){
}
func readId{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(loc: felt) -> (val: felt){
    alloc_locals;
    let (id) = WARP_STORAGE.read(loc);
    if (id == 0){
        let (id) = WARP_NAMEGEN.read();
        WARP_NAMEGEN.write(id + 1);
        WARP_STORAGE.write(loc, id + 1);
        return (id + 1,);
    }else{
        return (id,);
    }
}

namespace ERC20{

    // Dynamic variables - Arrays and Maps

    const __warp_usrid_01_balanceOf = 1;

    const __warp_usrid_02_allowance = 2;

    const __warp_usrid_03_name = 3;

    const __warp_usrid_04_symbol = 4;

    // Static variables

    const __warp_usrid_00_totalSupply = 0;

    const __warp_usrid_05_decimals = 6;


    func __warp_init_ERC20{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, warp_memory : DictAccess*}()-> (){
    alloc_locals;


        
        let (wm___warp_usrid_03_name) = WM0_d_arr(83, 111, 108, 105, 100, 105, 116, 121, 32, 98, 121, 32, 69, 120, 97, 109, 112, 108, 101);
        
        wm_to_storage0(__warp_usrid_03_name, wm___warp_usrid_03_name);
        
        let (wm___warp_usrid_04_symbol) = WM1_d_arr(83, 79, 76, 66, 89, 69, 88);
        
        wm_to_storage0(__warp_usrid_04_symbol, wm___warp_usrid_04_symbol);
        
        WS_WRITE1(__warp_usrid_05_decimals, 18);
        
        
        
        return ();

    }

}


    @external
    func transfer_a9059cbb{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_usrid_06_recipient : felt, __warp_usrid_07_amount : Uint256)-> (__warp_usrid_08_ : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_usrid_07_amount);
        
        warp_external_input_check_address(__warp_usrid_06_recipient);
        
        let (__warp_cs_0) = get_caller_address();
        
        let (__warp_se_0) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_0);
        
        let (__warp_se_1) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_0);
        
        let (__warp_se_2) = WS1_READ_Uint256(__warp_se_1);
        
        let (__warp_se_3) = warp_sub256(__warp_se_2, __warp_usrid_07_amount);
        
        WS_WRITE0(__warp_se_0, __warp_se_3);
        
        let __warp_cs_1 = __warp_usrid_06_recipient;
        
        let (__warp_se_4) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_1);
        
        let (__warp_se_5) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_1);
        
        let (__warp_se_6) = WS1_READ_Uint256(__warp_se_5);
        
        let (__warp_se_7) = warp_add256(__warp_se_6, __warp_usrid_07_amount);
        
        WS_WRITE0(__warp_se_4, __warp_se_7);
        
        let (__warp_se_8) = get_caller_address();
        
        Transfer_ddf252ad.emit(__warp_se_8, __warp_usrid_06_recipient, __warp_usrid_07_amount);
        
        
        
        return (1,);

    }


    @external
    func approve_095ea7b3{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_usrid_09_spender : felt, __warp_usrid_10_amount : Uint256)-> (__warp_usrid_11_ : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_usrid_10_amount);
        
        warp_external_input_check_address(__warp_usrid_09_spender);
        
        let (__warp_se_9) = get_caller_address();
        
        let (__warp_se_10) = WS1_INDEX_felt_to_warp_id(ERC20.__warp_usrid_02_allowance, __warp_se_9);
        
        let (__warp_se_11) = WS0_READ_warp_id(__warp_se_10);
        
        let (__warp_se_12) = WS0_INDEX_felt_to_Uint256(__warp_se_11, __warp_usrid_09_spender);
        
        WS_WRITE0(__warp_se_12, __warp_usrid_10_amount);
        
        let (__warp_se_13) = get_caller_address();
        
        Approval_8c5be1e5.emit(__warp_se_13, __warp_usrid_09_spender, __warp_usrid_10_amount);
        
        
        
        return (1,);

    }


    @external
    func transferFrom_23b872dd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_usrid_12_sender : felt, __warp_usrid_13_recipient : felt, __warp_usrid_14_amount : Uint256)-> (__warp_usrid_15_ : felt){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_usrid_14_amount);
        
        warp_external_input_check_address(__warp_usrid_13_recipient);
        
        warp_external_input_check_address(__warp_usrid_12_sender);
        
        let (__warp_cs_2) = get_caller_address();
        
        let __warp_cs_3 = __warp_usrid_12_sender;
        
        let (__warp_se_14) = WS1_INDEX_felt_to_warp_id(ERC20.__warp_usrid_02_allowance, __warp_cs_3);
        
        let (__warp_se_15) = WS0_READ_warp_id(__warp_se_14);
        
        let (__warp_se_16) = WS0_INDEX_felt_to_Uint256(__warp_se_15, __warp_cs_2);
        
        let (__warp_se_17) = WS1_INDEX_felt_to_warp_id(ERC20.__warp_usrid_02_allowance, __warp_cs_3);
        
        let (__warp_se_18) = WS0_READ_warp_id(__warp_se_17);
        
        let (__warp_se_19) = WS0_INDEX_felt_to_Uint256(__warp_se_18, __warp_cs_2);
        
        let (__warp_se_20) = WS1_READ_Uint256(__warp_se_19);
        
        let (__warp_se_21) = warp_sub256(__warp_se_20, __warp_usrid_14_amount);
        
        WS_WRITE0(__warp_se_16, __warp_se_21);
        
        let __warp_cs_4 = __warp_usrid_12_sender;
        
        let (__warp_se_22) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_4);
        
        let (__warp_se_23) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_4);
        
        let (__warp_se_24) = WS1_READ_Uint256(__warp_se_23);
        
        let (__warp_se_25) = warp_sub256(__warp_se_24, __warp_usrid_14_amount);
        
        WS_WRITE0(__warp_se_22, __warp_se_25);
        
        let __warp_cs_5 = __warp_usrid_13_recipient;
        
        let (__warp_se_26) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_5);
        
        let (__warp_se_27) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_5);
        
        let (__warp_se_28) = WS1_READ_Uint256(__warp_se_27);
        
        let (__warp_se_29) = warp_add256(__warp_se_28, __warp_usrid_14_amount);
        
        WS_WRITE0(__warp_se_26, __warp_se_29);
        
        Transfer_ddf252ad.emit(__warp_usrid_12_sender, __warp_usrid_13_recipient, __warp_usrid_14_amount);
        
        
        
        return (1,);

    }


    @external
    func mint_a0712d68{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_usrid_16_amount : Uint256)-> (){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_usrid_16_amount);
        
        let (__warp_cs_6) = get_caller_address();
        
        let (__warp_se_30) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_6);
        
        let (__warp_se_31) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_6);
        
        let (__warp_se_32) = WS1_READ_Uint256(__warp_se_31);
        
        let (__warp_se_33) = warp_add256(__warp_se_32, __warp_usrid_16_amount);
        
        WS_WRITE0(__warp_se_30, __warp_se_33);
        
        let (__warp_se_34) = WS1_READ_Uint256(ERC20.__warp_usrid_00_totalSupply);
        
        let (__warp_se_35) = warp_add256(__warp_se_34, __warp_usrid_16_amount);
        
        WS_WRITE0(ERC20.__warp_usrid_00_totalSupply, __warp_se_35);
        
        let (__warp_se_36) = get_caller_address();
        
        Transfer_ddf252ad.emit(0, __warp_se_36, __warp_usrid_16_amount);
        
        
        
        return ();

    }


    @external
    func burn_42966c68{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt, bitwise_ptr : BitwiseBuiltin*}(__warp_usrid_17_amount : Uint256)-> (){
    alloc_locals;


        
        warp_external_input_check_int256(__warp_usrid_17_amount);
        
        let (__warp_cs_7) = get_caller_address();
        
        let (__warp_se_37) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_7);
        
        let (__warp_se_38) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_cs_7);
        
        let (__warp_se_39) = WS1_READ_Uint256(__warp_se_38);
        
        let (__warp_se_40) = warp_sub256(__warp_se_39, __warp_usrid_17_amount);
        
        WS_WRITE0(__warp_se_37, __warp_se_40);
        
        let (__warp_se_41) = WS1_READ_Uint256(ERC20.__warp_usrid_00_totalSupply);
        
        let (__warp_se_42) = warp_sub256(__warp_se_41, __warp_usrid_17_amount);
        
        WS_WRITE0(ERC20.__warp_usrid_00_totalSupply, __warp_se_42);
        
        let (__warp_se_43) = get_caller_address();
        
        Transfer_ddf252ad.emit(__warp_se_43, 0, __warp_usrid_17_amount);
        
        
        
        return ();

    }


    @view
    func totalSupply_18160ddd{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_usrid_18_ : Uint256){
    alloc_locals;


        
        let (__warp_se_44) = WS1_READ_Uint256(ERC20.__warp_usrid_00_totalSupply);
        
        
        
        return (__warp_se_44,);

    }


    @view
    func balanceOf_70a08231{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_usrid_19__i0 : felt)-> (__warp_usrid_20_ : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_usrid_19__i0);
        
        let (__warp_se_45) = WS0_INDEX_felt_to_Uint256(ERC20.__warp_usrid_01_balanceOf, __warp_usrid_19__i0);
        
        let (__warp_se_46) = WS1_READ_Uint256(__warp_se_45);
        
        
        
        return (__warp_se_46,);

    }


    @view
    func allowance_dd62ed3e{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(__warp_usrid_21__i0 : felt, __warp_usrid_22__i1 : felt)-> (__warp_usrid_23_ : Uint256){
    alloc_locals;


        
        warp_external_input_check_address(__warp_usrid_22__i1);
        
        warp_external_input_check_address(__warp_usrid_21__i0);
        
        let (__warp_se_47) = WS1_INDEX_felt_to_warp_id(ERC20.__warp_usrid_02_allowance, __warp_usrid_21__i0);
        
        let (__warp_se_48) = WS0_READ_warp_id(__warp_se_47);
        
        let (__warp_se_49) = WS0_INDEX_felt_to_Uint256(__warp_se_48, __warp_usrid_22__i1);
        
        let (__warp_se_50) = WS1_READ_Uint256(__warp_se_49);
        
        
        
        return (__warp_se_50,);

    }


    @view
    func name_06fdde03{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_usrid_24__len : felt, __warp_usrid_24_ : felt*){
    alloc_locals;


        
        let (__warp_se_51) = ws_dynamic_array_to_calldata0(ERC20.__warp_usrid_03_name);
        
        
        
        return (__warp_se_51.len, __warp_se_51.ptr,);

    }


    @view
    func symbol_95d89b41{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_usrid_25__len : felt, __warp_usrid_25_ : felt*){
    alloc_locals;


        
        let (__warp_se_52) = ws_dynamic_array_to_calldata0(ERC20.__warp_usrid_04_symbol);
        
        
        
        return (__warp_se_52.len, __warp_se_52.ptr,);

    }


    @view
    func decimals_313ce567{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}()-> (__warp_usrid_26_ : felt){
    alloc_locals;


        
        let (__warp_se_53) = WS2_READ_felt(ERC20.__warp_usrid_05_decimals);
        
        
        
        return (__warp_se_53,);

    }


    @constructor
    func constructor{syscall_ptr : felt*, pedersen_ptr : HashBuiltin*, range_check_ptr : felt}(){
    alloc_locals;
    WARP_USED_STORAGE.write(7);
    WARP_NAMEGEN.write(4);
    let (local warp_memory : DictAccess*) = default_dict_new(0);
    local warp_memory_start: DictAccess* = warp_memory;
    dict_write{dict_ptr=warp_memory}(0,1);
    with warp_memory{

        
        ERC20.__warp_init_ERC20();
        
        default_dict_finalize(warp_memory_start, warp_memory, 0);
        
        
        return ();
    }
    }

// Original soldity abi: ["constructor()","transfer(address,uint256)","approve(address,uint256)","transferFrom(address,address,uint256)","mint(uint256)","burn(uint256)","totalSupply()","balanceOf(address)","allowance(address,address)","name()","symbol()","decimals()"]