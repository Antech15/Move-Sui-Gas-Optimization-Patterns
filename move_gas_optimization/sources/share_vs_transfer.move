module move_gas_optimization::share_vs_transfer {
    
    public struct MyObject has key, store {
        id: UID,
        value: u64
    }

    public struct MyObjects has key, store {
        id: UID,
        vec: vector<MyObject>,
    }

    public fun create_object(ctx: &mut TxContext): MyObject {
        let object = MyObject {
                id: object::new(ctx),
                value: 1
            };

        object
    }

    public entry fun create_2000_wrapped_shared(ctx: &mut TxContext) {
        let mut vec = vector::empty<MyObject>();
        let mut k:u64 = 0;
        while (k < 2000) {
            vector::push_back(&mut vec, create_object(ctx));
            k = k + 1;
        };

        let objects = MyObjects {
            id: object::new(ctx),
            vec: vec,
        };

        transfer::share_object(objects);
    }

    public entry fun create_2000_wrapped_transferred(ctx: &mut TxContext) {
        let mut vec = vector::empty<MyObject>();
        let mut k:u64 = 0;
        while (k < 2000) {
            vector::push_back(&mut vec, create_object(ctx));
            k = k + 1;
        };

        let objects = MyObjects {
            id: object::new(ctx),
            vec: vec,
        };

        transfer::transfer(objects, tx_context::sender(ctx));
    }

    public entry fun share2000(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 2000) {
            transfer::transfer(create_object(ctx), tx_context::sender(ctx));
            k = k + 1;
        };
    }

    public entry fun transfer2000(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 2000) {
            transfer::share_object(create_object(ctx));
            k = k + 1;
        };
    }

}
