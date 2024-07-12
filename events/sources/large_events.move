/// Module: events
module events::large_event {
    use sui::event;

    public struct LargeEvent has copy, drop {
        num1: u64,
        num2: u64,
        num3: u64,
        num4: u64,
        vec: vector<u64>,
    }

    //minimum fees
    public entry fun single_event() {

        let mut vec = vector::empty<u64>();
        let mut k:u64 = 0;
        while (k < 10000) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let event = LargeEvent {
            num1: 1,
            num2: 2,
            num3: 3,
            num4: 4,
            vec: vec,
            };

        event::emit(event);
    }

    //maximum allowed + slighlty higher fee
    public entry fun simple_event_loop() {

        let mut vec = vector::empty<u64>();
        let mut k:u64 = 0;
        while (k < 10000) {
            vector::push_back(&mut vec, k);
            k = k + 1;
        };

        let event = LargeEvent {
            num1: 1,
            num2: 2,
            num3: 3,
            num4: 4,
            vec: vec,
            };

        k = 0;
        while (k < 3) {
            event::emit(event);
            k = k + 1;
        }
    }

    //much higher fees, different
    /*public entry fun transfer_and_event_loop(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 1024) {
            transfer_with_event(ctx);
            k = k + 1;
        }
    }
    public entry fun transfer_and_no_event_loop(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 1024) {
            transfer_with_no_event(ctx);
            k = k + 1;
        }
    }

    //no difference in fees
    public entry fun transfer_with_event(ctx: &mut TxContext) {
        let id = object::new(ctx);

        event::emit(ObjectInfo {id: id.to_inner(), sender: ctx.sender() });

        transfer::transfer(MyObject { id, num: 10 }, ctx.sender());
    }

    public entry fun transfer_with_no_event(ctx: &mut TxContext) {
        let id = object::new(ctx);

        transfer::transfer(MyObject { id, num: 10 }, ctx.sender())
    }

    public entry fun update_object_and_event(object: &mut MyObject, new_value: u64) {
        object.num = new_value;

        event::emit(ObjectInfo2{id: object::id(object), num: new_value});
    }

    public entry fun update_object_and_event_loop(object: &mut MyObject, new_value: u64) {
        let mut k:u64 = 0;

        while(k < 1024) {
            update_object_and_event(object, new_value);
            k = k + 1;
        }
    }

    public entry fun update_object_no_event(object: &mut MyObject, new_value: u64) {
        object.num = new_value;
    }
    public entry fun update_object_no_event_loop(object: &mut MyObject, new_value: u64) {
        let mut k:u64 = 0;

        while(k < 1024) {
            update_object_no_event(object, new_value);
            k = k + 1;
        }
    }*/


}