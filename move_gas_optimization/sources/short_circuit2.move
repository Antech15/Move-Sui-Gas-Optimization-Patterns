module move_gas_optimization::short_circuit2 {

    //returns true
    public fun expensive_function(): bool {
        let mut k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k != 0);
        b
    }

    //returns false
    public fun cheap_function(): bool {
        let mut k:u64 = 0;
        while (k < 10000) {
            k = k + 1;
        };
        let b: bool = (k == 0);
        b
    }


    // T && F
    public entry fun no_short_circuit() {
        if (expensive_function() && cheap_function()) {

        };
    }

    // F && T
    public entry fun short_circuit() {
        if (cheap_function() && expensive_function()) {

        };
    }
}
