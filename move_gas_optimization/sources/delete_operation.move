module move_gas_optimization::delete_operation {
    use sui::dynamic_field;
    use sui::bag;

    public struct Parent has key, store {
        id: UID
    }

    public struct Child has key, store {
        id: UID,
        num: u64
    }

    public entry fun create_parent(ctx: &mut TxContext) {
        let mut parent = Parent{id: object::new(ctx)};
        let mut bag_object = bag::new(ctx);

        let mut k = 0;
        while(k < 999) {
            bag::add(&mut bag_object, k, Child{id: object::new(ctx), num: k});
            k = k + 1;
        };

        dynamic_field::add(&mut parent.id, b"bag", bag_object);
        transfer::transfer(parent, tx_context::sender(ctx));
    }

    public entry fun access(obj: &mut Parent) {
        let bag_ref: &mut bag::Bag = dynamic_field::borrow_mut(&mut obj.id, b"bag");

        let mut temp: &mut Child;

        let mut k = 0;
        while(k < 999) {
            temp = bag::borrow_mut(bag_ref, k);

            k = k + 1;
        };
    }

    public entry fun update(obj: &mut Parent) {
        let bag_ref: &mut bag::Bag = dynamic_field::borrow_mut(&mut obj.id, b"bag");

        let mut temp: &mut Child;

        let mut k = 0;
        while(k < 999) {
            temp = bag::borrow_mut(bag_ref, k);
            
            temp.num = 15;

            k = k + 1;
        };
    }

    public entry fun delete(mut obj: Parent) {
        let bag_ref: &mut bag::Bag = dynamic_field::borrow_mut(&mut obj.id, b"bag");

        let mut k = 0;
        while(k < 999) {
            let Child {id, num:_} = bag::remove(bag_ref, k);

            object::delete(id);
            k = k + 1;
        };

        bag::destroy_empty(dynamic_field::remove(&mut obj.id, b"bag"));
        let Parent{id} = obj;
        object::delete(id);
    }


}