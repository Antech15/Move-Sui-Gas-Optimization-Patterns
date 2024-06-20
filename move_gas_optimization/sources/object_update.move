module move_gas_optimization::object_update {

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
    
    public entry fun bad_object_update(object: &mut MyObject, new_value: u8, ctx: &mut TxContext) {
        let mut k:u64 = 0;
        let mut result = object;

        while (k < 10) {

            let MyObject {
                id: _,
                a,
                b,
                c,
                d,
                vec,
                w,
                x: _,
                y,
                z
            } = result;

            // create new object
            let result = MyObject {
                id: object::new(ctx),
                a: *a,
                b: *b,
                c: *c,
                d: *d,
                vec: *vec,
                w: *w,
                x: new_value,
                y: *y,
                z: *z
            };

            k = k + 1;
            transfer::share_object(result);        
        };
    }


    public entry fun good_object_update(object: &mut MyObject, new_value: u8) {
        let mut k:u64 = 0;
        while (k < 10) {
            object.x = new_value;
            k = k + 1;
        };
    }
}
