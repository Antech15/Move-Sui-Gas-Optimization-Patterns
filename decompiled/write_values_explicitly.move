module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::write_values_explicitly {
    public entry fun calculate() {
        helper(sum(10000));
    }
    
    public entry fun explicit() {
        helper(50005000);
    }
    
    public fun helper(arg0: u128) : u128 {
        arg0
    }
    
    public fun sum(arg0: u128) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < arg0) {
            v0 = v0 + v1;
            v1 = v1 + 1;
        };
        v0
    }
    
    // decompiled from Move bytecode v6
}

