module move_gas_optimization::variable_packing_object {

    public struct MyObject has key, store {
        id: UID,
        x8: u64, 
        x32: u64,
        x24: u64
    }

    public struct MyPackedObject has key, store {
        id: UID,
        x: u64
    }

    public entry fun create_object(ctx: &mut TxContext) {
        let object = MyObject {
                id: object::new(ctx),
                x8: 1,
                x32: 1,
                x24: 1
            };

        transfer::transfer(object, tx_context::sender(ctx));
    }


    public entry fun create_packed_object(ctx: &mut TxContext) {
        let object =  MyPackedObject {
                id: object::new(ctx),
                x: 1
            };

        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun no_variable_packing(object: &mut MyObject) {

        let mut x8: u64;
        let mut x32: u64;
        let mut x24: u64;

        let mut k:u64 = 0;
        while (k < 10000) {
            x8  = object.x8;
            x32 = object.x32;
            x24 = object.x24;
            
            k = k + 1;
        };
    }

    public entry fun variable_packing(packed_object: &mut MyPackedObject) {
        let mut x: u64;
        let mut x8: u64;
        let mut x32: u64;
        let mut x24: u64;

        let mut k:u64 = 0;
        while (k < 10000) {
	    x   = packed_object.x;

            x8  = (x & 0xF);
            x32 = ((x & (0xFFFF << 8)) >> 8);
            x24 = ((x & (0xFFF << 40)) >> 40);
            
            k = k + 1;
        };
    }
}
