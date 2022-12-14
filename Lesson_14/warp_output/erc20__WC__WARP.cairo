%lang starknet

from warplib.maths.external_input_check_address import warp_external_input_check_address
from warplib.maths.external_input_check_ints import warp_external_input_check_int256
from starkware.cairo.common.uint256 import Uint256
from starkware.cairo.common.cairo_builtins import HashBuiltin, BitwiseBuiltin
from warplib.maths.add import warp_add256
from starkware.starknet.common.syscalls import get_caller_address
from warplib.maths.ge import warp_ge256
from warplib.maths.sub_unsafe import warp_sub_unsafe256

func WS0_READ_Uint256{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    loc: felt
) -> (val: Uint256) {
    alloc_locals;
    let (read0) = WARP_STORAGE.read(loc);
    let (read1) = WARP_STORAGE.read(loc + 1);
    return (Uint256(low=read0, high=read1),);
}

func WS_WRITE0{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    loc: felt, value: Uint256
) -> (res: Uint256) {
    WARP_STORAGE.write(loc, value.low);
    WARP_STORAGE.write(loc + 1, value.high);
    return (value,);
}

@storage_var
func WARP_MAPPING0(name: felt, index: felt) -> (resLoc: felt) {
}
func WS0_INDEX_felt_to_Uint256{
    syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt
}(name: felt, index: felt) -> (res: felt) {
    alloc_locals;
    let (existing) = WARP_MAPPING0.read(name, index);
    if (existing == 0) {
        let (used) = WARP_USED_STORAGE.read();
        WARP_USED_STORAGE.write(used + 2);
        WARP_MAPPING0.write(name, index, used);
        return (used,);
    } else {
        return (existing,);
    }
}

// Contract Def WARP

@storage_var
func WARP_STORAGE(index: felt) -> (val: felt) {
}
@storage_var
func WARP_USED_STORAGE() -> (val: felt) {
}
@storage_var
func WARP_NAMEGEN() -> (name: felt) {
}
func readId{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(loc: felt) -> (
    val: felt
) {
    alloc_locals;
    let (id) = WARP_STORAGE.read(loc);
    if (id == 0) {
        let (id) = WARP_NAMEGEN.read();
        WARP_NAMEGEN.write(id + 1);
        WARP_STORAGE.write(loc, id + 1);
        return (id + 1,);
    } else {
        return (id,);
    }
}

namespace WARP {
    // Dynamic variables - Arrays and Maps

    const __warp_usrid_00__balances = 1;

    // Static variables

    const __warp_usrid_01__totalSupply = 1;

    func _transfer_30e0789e{
        syscall_ptr: felt*,
        pedersen_ptr: HashBuiltin*,
        range_check_ptr: felt,
        bitwise_ptr: BitwiseBuiltin*,
    }(
        __warp_usrid_16_sender: felt,
        __warp_usrid_17_recipient: felt,
        __warp_usrid_18_amount: Uint256,
    ) -> () {
        alloc_locals;

        let (__warp_se_8) = WS0_INDEX_felt_to_Uint256(
            __warp_usrid_00__balances, __warp_usrid_16_sender
        );

        let (__warp_usrid_19_senderBalance) = WS0_READ_Uint256(__warp_se_8);

        let (__warp_se_9) = warp_ge256(__warp_usrid_19_senderBalance, __warp_usrid_18_amount);

        assert __warp_se_9 = 1;

        let (__warp_se_10) = WS0_INDEX_felt_to_Uint256(
            __warp_usrid_00__balances, __warp_usrid_16_sender
        );

        let (__warp_se_11) = warp_sub_unsafe256(
            __warp_usrid_19_senderBalance, __warp_usrid_18_amount
        );

        WS_WRITE0(__warp_se_10, __warp_se_11);

        let __warp_cs_1 = __warp_usrid_17_recipient;

        let (__warp_se_12) = WS0_INDEX_felt_to_Uint256(__warp_usrid_00__balances, __warp_cs_1);

        let (__warp_se_13) = WS0_INDEX_felt_to_Uint256(__warp_usrid_00__balances, __warp_cs_1);

        let (__warp_se_14) = WS0_READ_Uint256(__warp_se_13);

        let (__warp_se_15) = warp_add256(__warp_se_14, __warp_usrid_18_amount);

        WS_WRITE0(__warp_se_12, __warp_se_15);

        return ();
    }

    func __warp_init_WARP{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
        ) -> () {
        alloc_locals;

        WS_WRITE0(__warp_usrid_01__totalSupply, Uint256(low=100000000000000, high=0));

        return ();
    }
}

@view
func decimals_313ce567{syscall_ptr: felt*, range_check_ptr: felt}() -> (__warp_usrid_02_: felt) {
    alloc_locals;

    return (18,);
}

@view
func totalSupply_18160ddd{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    ) -> (__warp_usrid_03_: Uint256) {
    alloc_locals;

    let (__warp_se_0) = WS0_READ_Uint256(WARP.__warp_usrid_01__totalSupply);

    return (__warp_se_0,);
}

@view
func balanceOf_70a08231{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    __warp_usrid_04_account: felt
) -> (__warp_usrid_05_: Uint256) {
    alloc_locals;

    warp_external_input_check_address(__warp_usrid_04_account);

    let (__warp_se_1) = WS0_INDEX_felt_to_Uint256(
        WARP.__warp_usrid_00__balances, __warp_usrid_04_account
    );

    let (__warp_se_2) = WS0_READ_Uint256(__warp_se_1);

    return (__warp_se_2,);
}

@external
func mint_40c10f19{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    __warp_usrid_06_to: felt, __warp_usrid_07_amount: Uint256
) -> (__warp_usrid_08_: felt) {
    alloc_locals;

    warp_external_input_check_int256(__warp_usrid_07_amount);

    warp_external_input_check_address(__warp_usrid_06_to);

    let __warp_cs_0 = __warp_usrid_06_to;

    let (__warp_se_3) = WS0_INDEX_felt_to_Uint256(WARP.__warp_usrid_00__balances, __warp_cs_0);

    let (__warp_se_4) = WS0_INDEX_felt_to_Uint256(WARP.__warp_usrid_00__balances, __warp_cs_0);

    let (__warp_se_5) = WS0_READ_Uint256(__warp_se_4);

    let (__warp_se_6) = warp_add256(__warp_se_5, __warp_usrid_07_amount);

    WS_WRITE0(__warp_se_3, __warp_se_6);

    return (1,);
}

@external
func transfer_a9059cbb{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr: felt,
    bitwise_ptr: BitwiseBuiltin*,
}(__warp_usrid_09_recipient: felt, __warp_usrid_10_amount: Uint256) -> (__warp_usrid_11_: felt) {
    alloc_locals;

    warp_external_input_check_int256(__warp_usrid_10_amount);

    warp_external_input_check_address(__warp_usrid_09_recipient);

    let (__warp_se_7) = get_caller_address();

    WARP._transfer_30e0789e(__warp_se_7, __warp_usrid_09_recipient, __warp_usrid_10_amount);

    return (1,);
}

@external
func transferFrom_23b872dd{
    syscall_ptr: felt*,
    pedersen_ptr: HashBuiltin*,
    range_check_ptr: felt,
    bitwise_ptr: BitwiseBuiltin*,
}(
    __warp_usrid_12_sender: felt, __warp_usrid_13_recipient: felt, __warp_usrid_14_amount: Uint256
) -> (__warp_usrid_15_: felt) {
    alloc_locals;

    warp_external_input_check_int256(__warp_usrid_14_amount);

    warp_external_input_check_address(__warp_usrid_13_recipient);

    warp_external_input_check_address(__warp_usrid_12_sender);

    WARP._transfer_30e0789e(
        __warp_usrid_12_sender, __warp_usrid_13_recipient, __warp_usrid_14_amount
    );

    return (1,);
}

@view
func _balances_6ebcf607{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    __warp_usrid_23__i0: felt
) -> (__warp_usrid_24_: Uint256) {
    alloc_locals;

    warp_external_input_check_address(__warp_usrid_23__i0);

    let (__warp_se_16) = WS0_INDEX_felt_to_Uint256(
        WARP.__warp_usrid_00__balances, __warp_usrid_23__i0
    );

    let (__warp_se_17) = WS0_READ_Uint256(__warp_se_16);

    return (__warp_se_17,);
}

@view
func _totalSupply_3eaaf86b{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}(
    ) -> (__warp_usrid_25_: Uint256) {
    alloc_locals;

    let (__warp_se_18) = WS0_READ_Uint256(WARP.__warp_usrid_01__totalSupply);

    return (__warp_se_18,);
}

@constructor
func constructor{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr: felt}() {
    alloc_locals;
    WARP_USED_STORAGE.write(3);
    WARP_NAMEGEN.write(1);

    WARP.__warp_init_WARP();

    return ();
}

// Original soldity abi: ["constructor()","decimals()","totalSupply()","balanceOf(address)","mint(address,uint256)","transfer(address,uint256)","transferFrom(address,address,uint256)","_balances(address)","_totalSupply()"]
