module move_gas_optimization::minimize_vector_element_operations {
    
    public entry fun bad_vector_access() {
        let mut vec = vector::empty<u64>();
        vector::push_back(&mut vec, 1);
        let mut k:u64 = 0;
        while (k < 1000) {
            k = k + *vector::borrow(&vec, 0);
        };
    }


    public entry fun good_vector_access() {
        let mut vec = vector::empty<u64>();
        vector::push_back(&mut vec, 1);
        let increment:u64 = *vector::borrow(&vec, 0);
        let mut k:u64 = 0;
        while (k < 1000) {
            k = k + increment;
        };
    }

}