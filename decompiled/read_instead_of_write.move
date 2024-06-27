module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::read_instead_of_write {
    struct MyObject has store, key {
        id: 0x2::object::UID,
        a: u128,
        b: u128,
        c: u128,
        d: u128,
        vec: vector<u64>,
        w: u8,
        x: u64,
        y: u8,
        z: u8,
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
    
    public entry fun reading(arg0: &mut MyObject) {
        let v0 = 0;
        while (v0 < 1000) {
            v0 = v0 + arg0.x;
        };
    }
    
    public entry fun writing(arg0: &mut MyObject) {
        let v0 = 0;
        let v1 = 10;
        while (v0 < 1000) {
            arg0.x = v1;
            v0 = v0 + v1;
        };
    }
    
    // decompiled from Move bytecode v6
}

