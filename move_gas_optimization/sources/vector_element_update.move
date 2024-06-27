module move_gas_optimization::vector_element_update {

    public entry fun direct_vector_element_update() {
        let mut vec = vector::empty<u256>();

        let mut k:u256 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        vector::remove(&mut vec, 5);
        vector::insert(&mut vec, 4, 5)
    }

    public entry fun delete_and_recreate_vector_element() {
        let mut vec = vector::empty<u256>();

        let mut k:u256 = 0;
        while (k < 100) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };


        //needs to be emptied to destory
        while(vector::length(& vec) > 0) {
            vector::pop_back(&mut vec);
        };

        vector::destroy_empty(vec);

        //new vector
        let mut vec2 = vector::empty<u256>();

        let mut k:u256 = 0;
        while (k < 100) {
            vector::push_back(&mut vec2, k);
            k = k + 1;
        };
    }
}
