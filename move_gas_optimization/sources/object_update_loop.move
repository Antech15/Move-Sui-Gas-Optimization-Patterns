module move_gas_optimization::object_update_loop {

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

    public fun helper_function(object: MyObject, new_value: u8, ctx: &mut TxContext): MyObject {
        let MyObject {
                id,
                a,
                b,
                c,
                d,
                vec,
                w,
                x: _,
                y,
                z
            } = object;

            id.delete();

            let new_object = MyObject {
                id: object::new(ctx),
                a: a,
                b: b,
                c: c,
                d: d,
                vec: vec,
                w: w,
                x: new_value,
                y: y,
                z: z
            };

            new_object
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
    
    public entry fun bad_object_update(mut object1: MyObject, new_value: u8, ctx: &mut TxContext) {

        let mut k:u64 = 0;

        while (k < 10000) {

            object1 = helper_function(object1, new_value, ctx);

            k = k + 1;
        };

        transfer::transfer(object1, tx_context::sender(ctx)); //result is moved here so no longer available (result variable is empty and useless)
    }


    public entry fun good_object_update(object: &mut MyObject, new_value: u8) {
        let mut k:u64 = 0;
        while (k < 10000) {
            object.x = new_value;
            k = k + 1;
        }
    }

}