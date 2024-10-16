/*
/// Module: sui_nft
module sui_nft::sui_nft;
*/
#[allow(duplicate_alias)]
module sui_nft::sui_nft{
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::string::String;

    public struct NFT has key, store{
        id: UID,
        name: String,
        description: String,
    }

    public entry fun mint(name:String,description:String, ctx: &mut TxContext){
        let nft = NFT{
            id: object::new(ctx),
            name ,
            description
        };
        let sender = tx_context::sender(ctx);
        transfer::public_transfer(nft, sender);
    } 

    public entry fun transfer(nft: NFT, recipient: address){
        transfer::transfer(nft, recipient);
    }



}