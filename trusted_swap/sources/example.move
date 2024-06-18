// Copyright (c) Mysten Labs, Inc.
// SPDX-License-Identifier: Apache-2.0

/// Executing a swap of two objects via a third party, using object wrapping to
/// hand ownership of the objects to swap to the third party without giving them
/// the ability to modify those objects.
module trusted_swap::example {
    use sui::balance::{Self, Balance};
    use sui::coin::{Self, Coin};
    use sui::sui::SUI;

    public struct Object has key, store {
        id: UID,
        scarcity: u8,
        style: u8,
    }

    public struct SwapRequest has key {
        id: UID,
        owner: address,
        object: Object,
        fee: Balance<SUI>,
    }

    // === Errors ===

    /// Fee is too low for the service
    const EFeeTooLow: u64 = 0;

    /// The two swap requests are not compatible
    const EBadSwap: u64 = 1;

    // === Constants ===

    const MIN_FEE: u64 = 10000000000000000000; //toolow
    const MIN_FEE: u64 = 1000; //regular

    // === Public Functions ===

    public fun new(scarcity: u8, style: u8, ctx: &mut TxContext): Object{
        Object { id: object::new(ctx), scarcity, style }
    }

    /// Anyone who owns an `Object` can make it available for swapping, which
    /// sends a `SwapRequest` to a `service` responsible for matching swaps.
    public fun request_swap(
        object: Object,
        fee: Coin<SUI>,
        _service: address,
        ctx: &mut TxContext,
    ): SwapRequest {
        assert!(coin::value(&fee) >= MIN_FEE, EFeeTooLow);


        let request = SwapRequest {
            id: object::new(ctx),
            owner: tx_context::sender(ctx),
            object,
            fee: coin::into_balance(fee),
        };
        request
    }

    /// When the service has two swap requests, it can execute them, sending the
    /// objects to the respective owners and taking its fee.
    public fun execute_swap(s1: SwapRequest, s2: SwapRequest): Balance<SUI> {//Balance<SUI> {
        let SwapRequest {id: id1, owner: owner1, object: o1, fee: mut fee1} = s1;
        let SwapRequest {id: id2, owner: owner2, object: o2, fee: fee2} = s2;

        assert!(o1.scarcity == o2.scarcity, EBadSwap);
        assert!(o1.style != o2.style, EBadSwap);

        // Perform the swap
        transfer::transfer(o1, owner2);
        transfer::transfer(o2, owner1);

        // Delete the wrappers
        object::delete(id1);
        object::delete(id2);

        // Take the fee and return it
        balance::join(&mut fee1, fee2);
        fee1
    }


        
    // === Tests ===
    //use sui::test_scenario as ts;

    public entry fun successful_swap(c1: Coin<SUI>, c2: Coin<SUI>, ctx: &mut TxContext) {
        //let mut ts = ts::begin(@0x0);
        //let alice = @0xA;
        //let bob = @0xB;
        //let custodian = @0xC;
        let thang1: SwapRequest;
        let thang2: SwapRequest;

            //ts::next_tx(&mut ts, alice);
            let o1 = new(1, 0, ctx);
            //let c1 = mint_for_testing<SUI>(MIN_FEE, ctx);
            let i = object::id(&o1);
            thang1 = request_swap(o1, c1, ctx.sender(), ctx);

            //ts::next_tx(&mut ts, bob);
            let o2 = new(1, 1, ctx);
            //let c2 = mint_for_testing<SUI>(MIN_FEE, ctx);
            let i = object::id(&o2);
            thang2 = request_swap(o2, c2, ctx.sender(), ctx);

            
            //let s1 = ts::take_from_sender<SwapRequest>(&ts);
            //let s2 = ts::take_from_sender<SwapRequest>(&ts);

            let bal = execute_swap(thang1, thang2);
            let fee = coin::from_balance(bal, ctx);

            transfer::public_transfer(fee, ctx.sender());

        
            //ts::next_tx(&mut ts, custodian);
            //let fee: Coin<SUI> = ts::take_from_sender(&ts);

            //assert!(ts::ids_for_address<Object>(alice) == vector[i2], 0);
            //assert!(ts::ids_for_address<Object>(bob) == vector[i1], 0);
            //assert!(coin::value(&fee) == MIN_FEE * 2, 0);

            //ts::return_to_sender(&ts, fee);
    }
    

    /*public entry fun swap_too_cheap(c1: Coin<SUI>, ctx: &mut TxContext) {


        let o1 = new(1, 0, ctx);
        let i = object::id(&o1);
            let thang1 = request_swap(o1, c1, ctx.sender(), ctx);

            //ts::next_tx(&mut ts, bob);
            let o2 = new(1, 1, ctx);
            //let c2 = mint_for_testing<SUI>(MIN_FEE, ctx);
            let i = object::id(&o2);
            thang2 = request_swap(o2, c2, ctx.sender(), ctx);

            
            //let s1 = ts::take_from_sender<SwapRequest>(&ts);
            //let s2 = ts::take_from_sender<SwapRequest>(&ts);

            let bal = execute_swap(thang1, thang2);
            let fee = coin::from_balance(bal, ctx);

            transfer::public_transfer(fee, ctx.sender());
    }*/
 
    public entry fun swap_different_scarcity(c1: Coin<SUI>, c2: Coin<SUI>, ctx: &mut TxContext) {

        
            let o1 = new(1, 0, ctx);
            let thang1 = request_swap(o1, c1, ctx.sender(), ctx);
        

        
            let o2 = new(0, 1, ctx);
            let thang2 = request_swap(o2, c2, ctx.sender(), ctx);
        

        
            let bal = execute_swap(thang1, thang2);

            let fee = coin::from_balance(bal, ctx);

            transfer::public_transfer(fee, ctx.sender());     
    }

    public entry fun swap_same_style(c1: Coin<SUI>, c2: Coin<SUI>, ctx: &mut TxContext) {


            let o1 = new(1, 0, ctx);
            let thang1 = request_swap(o1, c1, ctx.sender(), ctx);
        

        
            let o2 = new(1, 0, ctx);
            let thang2 = request_swap(o2, c2, ctx.sender(), ctx);
        

        
 
            let bal = execute_swap(thang1, thang2);

            let fee = coin::from_balance(bal, ctx);

            transfer::public_transfer(fee, ctx.sender());     
    }

}