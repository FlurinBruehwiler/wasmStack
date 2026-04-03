(module
    (import "js" "mem" (memory 1))
    (func $add (result i32)
        
        (local $i i32)
        (local $temp i32)
        
        (local $stackPointer i32)

        i32.const 100
        local.set $stackPointer

        i32.const 0
        local.set $i

        (loop $my_loop

            local.get $i
            i32.load

            local.tee $temp

            i32.const -1
            i32.eq

            (if
                (then
                    local.get $stackPointer
                    i32.load

                    ;; $stackPointer--
                    local.get $stackPointer
                    i32.const -4
                    i32.add
                    local.set $stackPointer

                    local.get $stackPointer
                    i32.load

                    
                    i32.add
                    local.set $temp

                    local.get $stackPointer
                    local.get $temp

                    i32.store

                    local.get $i
                    i32.const 4
                    i32.add
                    local.set $i

                    br $my_loop
                )
                (else
                    local.get $temp
                    i32.const -2
                    i32.eq

                    (if
                        (then

                            local.get $stackPointer
                            i32.load

                            ;; $stackPointer--
                            local.get $stackPointer
                            i32.const -4
                            i32.add
                            local.set $stackPointer

                            local.get $stackPointer
                            i32.load

                            i32.mul
                            local.set $temp

                            local.get $stackPointer
                            local.get $temp

                            i32.store

                            local.get $i
                            i32.const 4
                            i32.add
                            local.set $i

                            br $my_loop
                        )
                        (else
                            local.get $temp
                            i32.const -3
                            i32.eq

                            (if
                                (then
                                    
                                )
                                (else
                                    local.get $stackPointer
                                    i32.const 4
                                    i32.add
                                    local.set $stackPointer

                                    local.get $stackPointer
                                    local.get $temp
                                    i32.store 

                                    local.get $i
                                    i32.const 4
                                    i32.add
                                    local.set $i

                                    br $my_loop
                                )
                            )
                        )
                    )
                )
            )
        )

        local.get $stackPointer
        i32.load
    )
    (export "add" (func $add))
)
