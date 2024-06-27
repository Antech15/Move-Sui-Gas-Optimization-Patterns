module move_gas_optimization::delete_object {

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

        transfer::transfer(object, tx_context::sender(ctx));
    }
    
    public entry fun delete_object(object: MyObject) {

        let MyObject {
            id,
            a: _,
            b: _,
            c: _,
            d: _,
            vec: _,
            w: _,
            x: _,
            y: _,
            z: _
        } = object;

        id.delete();
    }

}