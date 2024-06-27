module move_gas_optimization::limit_function_calls2 {
   
   public fun helper_function() {
    }

    public entry fun function_call() {
        let mut k:u64 = 0;
        while (k < 10) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call2() {
        let mut k:u64 = 0;
        while (k < 100) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call3() {
        let mut k:u64 = 0;
        while (k < 1000) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call4() {
        let mut k:u64 = 0;
        while (k < 5000) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call5() {
        let mut k:u64 = 0;
        while (k < 8000) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call6() {
        let mut k:u64 = 0;
        while (k < 8500) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call7() {
        let mut k:u64 = 0;
        while (k < 9000) {
            helper_function();
            k = k + 1;
        };
    }
    
    public entry fun function_call8() {
        let mut k:u64 = 0;
        while (k < 9500) {
            helper_function();
            k = k + 1;
        };
    }

    public entry fun function_call9() {
        let mut k:u64 = 0;
        while (k < 9250) {
            helper_function();
            k = k + 1;
        };
    }
}
    
   
