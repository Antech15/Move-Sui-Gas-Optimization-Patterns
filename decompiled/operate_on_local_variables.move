module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::operate_on_local_variables {
    struct MyObject has store, key {
        id: 0x2::object::UID,
        value: u64,
    }
    
    public entry fun bad_object_write(arg0: &mut MyObject) {
        arg0.value = 0;
        while (arg0.value < 100000) {
            arg0.value = arg0.value + 1;
        };
    }
    
    public entry fun create_object(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MyObject{
            id    : 0x2::object::new(arg0), 
            value : 1,
        };
        0x2::transfer::transfer<MyObject>(v0, 0x2::tx_context::sender(arg0));
    }
    
    public entry fun good_object_write(arg0: &mut MyObject) {
        arg0.value = 0;
        let v0 = arg0.value;
        while (v0 < 100000) {
            v0 = v0 + 1;
        };
        arg0.value = v0;
    }
    
    // decompiled from Move bytecode v6
}

