/*
/// Module: person
module person::person;
*/
#[allow(duplicate_alias)]
module 0x0::Person {
    use std::string;
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

   public struct PersonObject has key, store {
        id: UID,
        name: string::String,
        city: string::String,
        age: u64,
        date_of_birth: u64,
    }

    public entry fun mint(ctx: &mut TxContext) {
        let object = PersonObject{
            id: object::new(ctx),
            name: string::utf8(b"Jaydip Patel"),
            city: string::utf8(b"Ahmedabad"),
            age: 30,
            date_of_birth: 1994
        };
        transfer::public_transfer(object, tx_context::sender(ctx));
    } 
}