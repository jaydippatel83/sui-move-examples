/*
/// Module: hello_world
module hello_world::hello_world;
*/
#[allow(duplicate_alias)]
module hello_world::hello_world {
    use std::string;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

   public struct HelloWorldObject has key, store {
        id: UID,
        message: string::String,
    }

    public entry fun mint(ctx: &mut TxContext) {
        let object = HelloWorldObject{
            id: object::new(ctx),
            message: string::utf8(b"Hello, World!"),
        };
        transfer::public_transfer(object, tx_context::sender(ctx));
    } 
}