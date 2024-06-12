module move_gas_optimization::read_instead_of_write {

    public struct MyObject has key, store {
        id: UID,
        a:u128,
        b:u128,
        c:u128,
        d:u128,
        vec: vector<u64>,
        w:u8,
        x:u8,
        y:u8,
        z:u8
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

            transfer::share_object(object)
    }

    public entry fun reading(object: &mut MyObject) {
        let mut k:u64 = 0;
        while (k < 1000) {
            let mut _x:u8;
            _x = object.x;
            k = k + 1;
        };

        

    }

    public entry fun writing(object: &mut MyObject) {
        let mut k:u64 = 0;
        while (k < 1000) {
            object.x = 1;
            k = k + 1;
        };
    }

}