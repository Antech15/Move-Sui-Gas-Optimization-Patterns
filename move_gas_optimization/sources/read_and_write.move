module move_gas_optimization::read_and_write {

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
    public fun helper_function(num: u128): u128 {
        num
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

    //#[allow(unused_assignment)] //compiler thinks x1 isn't used for some reason
    public entry fun read_one_field(object: &mut MyObject) {
        let mut k:u64 = 0;

        while (k < 10000) {
            helper_function(object.b);
            k = k + 1;
        };
    }

    //#[allow(unused_assignment)] //compiler thinks x1 isn't used for some reason
    public entry fun read_four_fields(object: &mut MyObject) {

        helper_function(object.a);
        helper_function(object.b);
        helper_function(object.c);
        helper_function(object.d);
    }
}