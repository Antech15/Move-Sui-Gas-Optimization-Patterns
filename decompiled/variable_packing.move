module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::variable_packing {
    struct MyObject has store, key {
        id: 0x2::object::UID,
        x8: u8,
        x32: u64,
        x24: u64,
    }
    
    struct MyPackedObject has store, key {
        id: 0x2::object::UID,
        x: u64,
    }
    
    public entry fun variable_packing(arg0: &mut MyPackedObject) {
        let _ = arg0.x;
        let v1 = 0;
        while (v1 < 10000) {
            v1 = v1 + 1;
        };
    }
    
    public entry fun create_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyObject{
            id  : 0x2::object::new(arg0), 
            x8  : 1, 
            x32 : 1, 
            x24 : 1,
        };
        0x2::transfer::transfer<MyObject>(v0, 0x2::tx_context::sender(arg0));
    }
    
    public entry fun create_packed_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyPackedObject{
            id : 0x2::object::new(arg0), 
            x  : 1,
        };
        0x2::transfer::transfer<MyPackedObject>(v0, 0x2::tx_context::sender(arg0));
    }
    
    public entry fun no_variable_packing(arg0: &mut MyObject) {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
    }
    
    // decompiled from Move bytecode v6
}

