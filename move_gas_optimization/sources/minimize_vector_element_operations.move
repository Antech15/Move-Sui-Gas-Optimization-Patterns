module move_gas_optimization::minimize_vector_element_operations {
    
    public entry fun bad_vector_access() {
        let mut vec = vector::empty<u256>();
        let mut k:u256 = 0;

        while (k < 10000) {
            vector::push_back(&mut vec, 1);
            k = k + 1;
        };

        k = 0;

        while (k < 100000) {
            k = k + *vector::borrow(&vec, 0);
            k = k + *vector::borrow(&vec, 1);
            k = k + *vector::borrow(&vec, 2);
        };
    }


    public entry fun good_vector_access() {
        let mut vec = vector::empty<u256>();

        let mut k:u256 = 0;
        while (k < 10000) {
            vector::push_back(&mut vec, 1);
            k = k + 1;
        };

        k = 0;

        let increment1:u256 = *vector::borrow(&vec, 0);
        let increment2:u256 = *vector::borrow(&vec, 1);
        let increment3:u256 = *vector::borrow(&vec, 2);

        while (k < 100000) {
            k = k + increment1;
            k = k + increment2;
            k = k + increment3
        };
    }

}