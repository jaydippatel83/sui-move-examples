/*
/// Module: feed_framwork
module feed_framwork::feed_framwork;
*/

module  SupraOracle::SupraSValueFeed{
    use std::vector;

    struct OracleHolder has key, store{
        id: sui::object::UID,
    }

    struct Price has drop{
        pair:u32,
        value:u128,
        decimals:u16,
        timestamp:u128,
        round:u64
    }

    native public fun get_price(_oracle_holder: &OracleHolder, _pair:u32):(u128,u16,u128, u64);
    native public fun get_prices(_oracle_holder: &OracleHolder, _pairs: vector<u32>):vector<Price>;
    native public fun extract_price(_price: &Price):(u32,u128,u16,u128,u64);

}