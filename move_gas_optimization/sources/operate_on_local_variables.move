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

        transfer::share_object(object)
    }

    public entry fun bad_object_write(object: &mut MyObject) {
        object.value = 0;
        while (object.value < 100000) {
            // operate on object.field
            object.value = object.value + 1;
            }
    }

    public entry fun good_object_write(object: &mut MyObject) {
        object.value = 0;
        let mut intermediate = object.value;

        while (intermediate < 100000) {
            // operate on intermediate
            intermediate = intermediate + 1;
        };
        object.value = intermediate;
    }
}
