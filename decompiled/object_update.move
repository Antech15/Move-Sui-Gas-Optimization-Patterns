module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::object_update {
    struct MyObject has store, key {
        id: 0x2::object::UID,
        a: u128,
        b: u128,
        c: u128,
        d: u128,
        vec: vector<u64>,
        w: u8,
        x: u8,
        y: u8,
        z: u8,
    }
    
    public entry fun bad_object_update(arg0: MyObject, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let MyObject {
            id  : v0,
            a   : v1,
            b   : v2,
            c   : v3,
            d   : v4,
            vec : v5,
            w   : v6,
            x   : _,
            y   : v8,
            z   : v9,
        } = arg0;
        0x2::object::delete(v0);
        let v10 = MyObject{
            id  : 0x2::object::new(arg2), 
            a   : v1, 
            b   : v2, 
            c   : v3, 
            d   : v4, 
            vec : v5, 
            w   : v6, 
            x   : arg1, 
            y   : v8, 
            z   : v9,
        };
        0x2::transfer::transfer<MyObject>(v10, 0x2::tx_context::sender(arg2));
    }
    
    public entry fun create_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u64>(&mut v0, v1);
            v1 = v1 + 1;
        };
        let v2 = MyObject{
            id  : 0x2::object::new(arg0), 
            a   : 1000, 
            b   : 1000, 
            c   : 1000, 
            d   : 1000, 
            vec : v0, 
            w   : 10, 
            x   : 10, 
            y   : 10, 
            z   : 10,
        };
        0x2::transfer::transfer<MyObject>(v2, 0x2::tx_context::sender(arg0));
    }
    
    public entry fun good_object_update(arg0: &mut MyObject, arg1: u8) {
        arg0.x = arg1;
    }
    
    // decompiled from Move bytecode v6
}
