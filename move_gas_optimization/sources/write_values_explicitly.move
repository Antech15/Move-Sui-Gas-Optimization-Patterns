module move_gas_optimization::write_values_explicitly {
   
    public fun sum(n: u128): u128 {
        let mut total:u128 = 0;
        let mut k:u128 = 0;
        while (k < n) {
            total = total + k;
            k = k + 1;
        };
        total
    }

    public fun helper(n: u128): u128 {
        n
    }

    public fun expensive_function(): bool {
        let mut k:u64 = 0;
        while (k < 100000) {
            k = k + 1;
        };
        let b: bool = (k != 0);
        b
    }

    public entry fun calculate() {
        expensive_function();
        let _x: u128 = sum(10000);

        helper(_x);
    }

    public entry fun explicit() {
        expensive_function();
        let x: u128 = 50005000;
        
        helper(x);

    }
}
