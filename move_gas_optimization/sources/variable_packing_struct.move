module move_gas_optimization::variable_packing_struct {

    public struct MyStruct has drop {
        x8: u64, 
        x32: u64,
        x24: u64
    }

    public struct MyPackedStruct has drop {
        x: u64
    }

    public entry fun no_variable_packing() {
        let my_struct = MyStruct {
                x8: 1,
                x32: 1,
                x24: 1
            };

        let mut x8: u64;
        let mut x32: u64;
        let mut x24: u64;

        let mut k:u64 = 0;
        while (k < 10000) {
            x8  = my_struct.x8;
            x32 = my_struct.x32;
            x24 = my_struct.x24;
            
            k = k + 1;
        };
    }

    public entry fun variable_packing() {
        let my_packed_struct =  MyPackedStruct {
                x: 1
            };

        let mut x: u64;
        let mut x8: u64;
        let mut x32: u64;
        let mut x24: u64;

        let mut k:u64 = 0;
        while (k < 10000) {
            x = my_packed_struct.x;

            x8  = (x & 0xF);
            x32 = ((x & (0xFFFF << 8)) >> 8);
            x24 = ((x & (0xFFF << 40)) >> 40);
            
            k = k + 1;
        };
    }
}
