module 0xd4658c34dfc23fcb169b4038c2a94f5183794acb46d9a5ea6a4b61c6756e996e::limit_function_calls {
    public entry fun function_call() {
        let v0 = 0;
        while (v0 < 10000) {
            helper_function();
            v0 = v0 + 1;
        };
    }
    
    public fun helper_function() {
    }
    
    public entry fun no_function_call() {
        let v0 = 0;
        while (v0 < 10000) {
            v0 = v0 + 1;
        };
    }
    
    // decompiled from Move bytecode v6
}
