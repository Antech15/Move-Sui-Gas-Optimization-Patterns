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

    public entry fun calculate() {
        let _x: u128 = sum(10000000000000000);

        helper(_x);
    }

    //Doesn't work 
    public entry fun explicit() {
        let x: u128 = 49999999999999995000000000000000;
        
        helper(x);

    }

}