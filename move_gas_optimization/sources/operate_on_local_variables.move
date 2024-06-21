module move_gas_optimization::operate_on_local_variables {
    
    public struct MyObject has key, store {
        id: UID,
        value: u64
    }

    public entry fun create_object(ctx: &mut TxContext) {
        let object = MyObject {
                id: object::new(ctx),
                value: 1
            };

        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun bad_object_write(object: &mut MyObject) {
        object.value = 0;

        while (object.value < 100000) {
            object.value = object.value + 1;
            }
    }

    public entry fun good_object_write(object: &mut MyObject) {
        object.value = 0;
        let mut intermediate = object.value;

        while (intermediate < 100000) {
            intermediate = intermediate + 1;
        };
        object.value = intermediate;
    }
}
