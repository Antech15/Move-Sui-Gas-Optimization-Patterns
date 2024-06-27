module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::minimize_vector_element_operations {
    public entry fun bad_vector_access() {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 10000) {
            0x1::vector::push_back<u256>(&mut v0, 1);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 10000) {
            let v2 = v1 + *0x1::vector::borrow<u256>(&v0, 0) + *0x1::vector::borrow<u256>(&v0, 1);
            v1 = v2 + *0x1::vector::borrow<u256>(&v0, 2);
        };
    }
    
    public entry fun good_vector_access() {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (v1 < 10000) {
            0x1::vector::push_back<u256>(&mut v0, 1);
            v1 = v1 + 1;
        };
        v1 = 0;
        while (v1 < 10000) {
            let v2 = v1 + *0x1::vector::borrow<u256>(&v0, 0) + *0x1::vector::borrow<u256>(&v0, 1);
            v1 = v2 + *0x1::vector::borrow<u256>(&v0, 2);
        };
    }
    
    // decompiled from Move bytecode v6
}
