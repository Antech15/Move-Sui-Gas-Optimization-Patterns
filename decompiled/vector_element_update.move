module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::vector_element_update {
    public entry fun delete_and_recreate_vector_element() {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u256>(&mut v0, v1);
            v1 = v1 + 1;
        };
        while (0x1::vector::length<u256>(&v0) > 0) {
            0x1::vector::pop_back<u256>(&mut v0);
        };
        0x1::vector::destroy_empty<u256>(v0);
        let v2 = 0x1::vector::empty<u256>();
        let v3 = 0;
        while (v3 < 100) {
            0x1::vector::push_back<u256>(&mut v2, v3);
            v3 = v3 + 1;
        };
    }
    
    public entry fun direct_vector_element_update() {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 100) {
            0x1::vector::push_back<u256>(&mut v0, v1);
            v1 = v1 + 1;
        };
        0x1::vector::remove<u256>(&mut v0, 5);
        0x1::vector::insert<u256>(&mut v0, 4, 5);
    }
    
    // decompiled from Move bytecode v6
}

