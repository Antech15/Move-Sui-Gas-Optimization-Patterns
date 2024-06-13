module move_gas_optimization::variable_packing {

    public struct MyObject has key, store {
        id: UID,
        x8: u8, 
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

            transfer::share_object(object);
    }


    public entry fun create_packed_object(ctx: &mut TxContext) {
        let object =  MyPackedObject {
                id: object::new(ctx),
                x: 1
            };

            transfer::share_object(object);
    }

    public entry fun no_variable_packing(object: &mut MyObject) {
        let mut k:u64 = 0;
        while (k < 10000) {
            let _x8:  u8  = object.x8;
            let _x32: u64 = object.x32;
            let _x24: u64 = object.x24;
            
            k = k + 1;
        };
    }

    public entry fun variable_packing(object: &mut MyPackedObject) {
        let x: u64 = object.x;

        let mut k:u64 = 0;
        while (k < 10000) {
            let _x8  = (x & 0xF);
            let _x32 = ((x & (0xFFFF << 8)) >> 8);
            let _x24 = ((x & (0xFFF << 40)) >> 40);
            
            k = k + 1;
        };
    }
    // 630 Octa

}