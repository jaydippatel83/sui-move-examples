#[allow(unused_variable)]
module examples::math {
	use sui::object::UID;
	use sui::tx_context::{Self, TxContext};

	// std::string import
	use std::string::{Self, String};

	// Declaring the Name
	public struct Numbers has key {
		id: UID,
		a: u8,
		b: u8,
	}

	// Initializing the constructor
	fun init(a: u8, b: u8, ctx: &mut TxContext) {
		let numbers = Numbers {
			id: object::new(ctx),
			name: string::utf8(name_bytes)
		}
	}

	public fun add(n: Numbers) {
		let sum = n.a + n.b;
	}

    public fun sub(n: Numbers){
		let result = n.a - n.b;
	}
}
