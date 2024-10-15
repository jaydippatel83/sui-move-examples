/*
/// Module: animal
module animal::animal;
*/

#[allow(duplicate_alias)]
module animal::animal {
    use sui::object::UID;
    use std::string::{Self, String};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

  public struct AnimalObject has key, store {
        id: UID,
        name: String,
        no_of_legs: u64,
        favorite_food: String,
    }

    public entry fun fun_animal(ctx: &mut TxContext){
        let animal = AnimalObject{
            id: object::new(ctx),
            name: string::utf8(b"Elephant"),
            no_of_legs: 4,
            favorite_food: string::utf8(b"Grass"),
        }; 
        transfer::transfer(animal, tx_context::sender(ctx));
    } 

}