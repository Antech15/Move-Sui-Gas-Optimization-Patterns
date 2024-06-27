module move_gas_optimization::read_instead_of_write2 {

    public struct MyObject has key, store {
        id: UID,
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u64,
        y:u8,
        z:u8
    }

    public fun expensive_function(): bool {
        let mut k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k != 0);
        b
    }

    public entry fun create_object(ctx: &mut TxContext) {
        let mut vec = vector::empty<u64>();
        let mut k:u64 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let object = MyObject {
                id: object::new(ctx),
                a:1000,
                b:1000,
                c:1000,
                d:1000,
                vec: vec,
                w:10,
                x:10,
                y:10,
                z:10
            };

            transfer::transfer(object, tx_context::sender(ctx));
    }

    #[allow(unused_assignment)] //compiler thinks x1 isn't used for some reason
    public entry fun reading(object: &mut MyObject) {
        expensive_function();

        let mut k:u64 = 0;
        let mut x1:u64 = 10;
        while (k < 100000) {
            x1 = object.x;
            k = k + x1;
        };
    }

    public entry fun writing(object: &mut MyObject) {
        expensive_function();

        let mut k:u64 = 0;
        let x1:u64 = 10;
        while (k < 100000) {
            object.x = x1;
            k = k + x1;
        };
    }
}