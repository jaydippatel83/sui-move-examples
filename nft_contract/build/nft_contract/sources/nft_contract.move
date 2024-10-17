/*
/// Module: nft_contract
module nft_contract::nft_contract;
*/
#[allow(duplicate_alias)]
module nft_contract::nft_contract {
		use sui::url::{Self, Url};
		use std::string;
		use sui::event;
        use sui::coin::{Self, Coin};
        use sui::sui::SUI;
        use sui::table::{Self, Table};
        use sui::transfer;
        use sui::object::{Self, ID, UID};
        use sui::tx_context::{Self, TxContext};

        public struct Marketplace has key {
            id: UID,
            listings: Table<ID, Listing>,
        }

        public struct Listing has store {
            price: u64,
            owner: address,
        }
 
		public struct NFT has key, store {
				id: UID, 
				name: string::String, 
				description: string::String, 
				url: Url, 
		} 

		public struct NFTMinted has copy, drop { 
				object_id: ID, 
				creator: address, 
				name: string::String,
		}

        fun init(ctx: &mut TxContext) {
            transfer::share_object(Marketplace {
                id: object::new(ctx),
                listings: table::new(ctx),
            });
        }
  
		public fun name(nft: &NFT): &string::String {
				&nft.name
		}
 
		public fun description(nft: &NFT): &string::String {
				&nft.description
		} 
		public fun url(nft: &NFT): &Url {
				&nft.url
		}
 

		#[allow(lint(self_transfer))] 
		public fun mint_to_sender(
				name: vector<u8>,
				description: vector<u8>,
				url: vector<u8>,
				ctx: &mut TxContext
		) {
				let sender = ctx.sender();
				let nft = NFT {
						id: object::new(ctx),
						name: string::utf8(name),
						description: string::utf8(description),
						url: url::new_unsafe_from_bytes(url)
				};

				event::emit(NFTMinted {
						object_id: object::id(&nft),
						creator: sender,
						name: nft.name,
				});

				transfer::public_transfer(nft, sender);
		}
 
		public fun transfer(
				nft: NFT, recipient: address, _: &mut TxContext
		) {
				transfer::public_transfer(nft, recipient)
		}
 
		public fun update_description(
				nft: &mut NFT,
				new_description: vector<u8>,
				_: &mut TxContext
		) {
				nft.description = string::utf8(new_description)
		}
 
		public fun burn(nft: NFT, _: &mut TxContext) {
				let NFT { id, name: _, description: _, url: _ } = nft;
				id.delete()
		} 

        #[allow(duplicate_alias)]
        public fun list_nft(
            marketplace: &mut Marketplace,
            nft: NFT,
            price: u64,
            ctx: &mut TxContext
        ): NFT {
            let nft_id = object::id(&nft);
            let sender = tx_context::sender(ctx);

            table::add(&mut marketplace.listings, nft_id, Listing { price, owner: sender });
            nft // Return the NFT instead of transferring it
        } 
        #[allow(duplicate_alias)]
        public fun buy_nft(
            marketplace: &mut Marketplace,
            nft: NFT,
            payment: &mut Coin<SUI>,
            ctx: &mut TxContext
        ): NFT {
            let nft_id = object::id(&nft);
            let Listing { price, owner } = table::remove(&mut marketplace.listings, nft_id);
            
            assert!(coin::value(payment) >= price, 0);
            
            let paid = coin::split(payment, price, ctx);
            transfer::public_transfer(paid, owner);
            nft // Return the NFT instead of transferring it
        }

        public fun cancel_listing(
            marketplace: &mut Marketplace,
            nft: &NFT,
            ctx: &mut TxContext
        ) {
            let nft_id = object::id(nft);
            let Listing { price: _, owner } = table::remove(&mut marketplace.listings, nft_id);
            assert!(owner == tx_context::sender(ctx), 0);
        }

        public fun get_listing(marketplace: &Marketplace, nft_id: ID): (u64, address) {
            let listing = table::borrow(&marketplace.listings, nft_id);
            (listing.price, listing.owner)
        }

        public fun is_listed(marketplace: &Marketplace, nft_id: ID): bool {
            table::contains(&marketplace.listings, nft_id)
        }

        
}