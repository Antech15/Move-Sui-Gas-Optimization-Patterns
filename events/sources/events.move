/// Module: events
module events::events {
    use sui::event;

    public struct Simple has copy, drop {
        num: u64
    }

    public struct MyObject has key {
        id: UID,
        num: u64
    }

    public struct ObjectInfo has copy, drop {
        id: ID,
        sender: address
    }

    //minimum fees
    public entry fun simple_event() {
        event::emit(Simple {num: 10});
    }

    //maximum allowed + slighlty higher fee
    public entry fun simple_event_loop() {
        let mut k:u64 = 0;
        while (k < 1024) {
            event::emit(Simple {num: k});
            k = k + 1;
        }
    }

    //much higher fees
    public entry fun transfer_event_loop(ctx: &mut TxContext) {
        let mut k:u64 = 0;
        while (k < 1024) {
            transfer_event(ctx);
            k = k + 1;
        }
    }


    //expensive?? function
    
    public entry fun transfer_event(ctx: &mut TxContext) {
        let id = object::new(ctx);

        event::emit(ObjectInfo {id: id.to_inner(), sender: ctx.sender() });

        transfer::transfer(MyObject { id, num: 10 }, ctx.sender())
    }

    public entry fun transfer_no_event(ctx: &mut TxContext) {
        let id = object::new(ctx);

        transfer::transfer(MyObject { id, num: 10 }, ctx.sender())
    }

}