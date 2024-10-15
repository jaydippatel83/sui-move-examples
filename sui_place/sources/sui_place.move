/*
/// Module: sui_place
module sui_place::sui_place;
*/
module sui_place::place {
    use std::vector;
    use sui::tx_context::{Self, TxContext};


    struct Place has key,store{
        id: UID,
    }

    struct Quadrant has key,store{
        id: UID,
        quadrant_id: u8,
        board: vector<vector<u32>>, 
    }

    fun init(ctx: &mut TxContext){
        // TODO: Implement the logic to initialize the game board
    }

    public fun set_pixel_at(place: &mut Place, x: u64, y: u64, color: u32){
        // TODO: Implement the logic to set a pixel at a specific coordinate
    }
     public fun get_pixel_at(place: &mut Place):vector<address>{
        // TODO: Implement the logic to get the pixel at a specific coordinate
    }
}