module move_gas_optimization::share_vs_transfer {
    
    public struct MyObject has key, store {
        id: UID,
        value: u64
    }

    public fun create_and_share(ctx: &mut TxContext) {
        let object = MyObject {
                id: object::new(ctx),
                value: 1
            };
        transfer::share_object(object);
    }

    public fun create_and_transfer(ctx: &mut TxContext) {
        let object = MyObject {
                id: object::new(ctx),
                value: 1
            };

        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun sharing(ctx: &mut TxContext) {
       let mut k:u64 = 0;
        while (k < 20) {
            create_and_share(ctx);

            k = k + 1;
        };
        
    }

    public entry fun transferring(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 20) {
            create_and_transfer(ctx);

            k = k + 1;
        };
    }

}
