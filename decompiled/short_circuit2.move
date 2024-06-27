module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::short_circuit2 {
    public fun cheap_function() : bool {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
        v0 == 0
    }
    
    public fun expensive_function() : bool {
        let v0 = 0;
        while (v0 < 100000) {
            v0 = v0 + 1;
        };
        v0 != 0
    }
    
    public entry fun no_short_circuit() {
        if (expensive_function()) {
        };
    }
    
    public entry fun short_circuit() {
        if (cheap_function()) {
        };
    }
    
    // decompiled from Move bytecode v6
}

