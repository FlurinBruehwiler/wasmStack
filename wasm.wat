(module
    (import "js" "mem" (memory 1))
    (func $execute (param $inputLength i32) (result i32)
        
        (local $i i32)
        (local $temp i32)
        
        (local $stackPointer i32)

        ;; $stackPointer = $inputLength;
        local.get $inputLength
        local.set $stackPointer

        ;; $i = -4
        i32.const -4
        local.set $i

        (block $return_block
        
            (loop $loop

                ;; i += 4
                local.get $i
                i32.const 4
                i32.add
                local.set $i

                ;; if ($i == inputLength) goto $return_block
                local.get $i
                local.get $inputLength
                i32.eq
                br_if $return_block

                ;; $temp = data[$i]
                local.get $i
                i32.load
                local.set $temp

                ;; handle +
                ;; $temp == -1
                local.get $temp
                i32.const -1
                i32.eq

                (if
                    (then
                        ;; load value at stackpointer
                        local.get $stackPointer
                        i32.load

                        ;; $stackPointer -= 4
                        local.get $stackPointer
                        i32.const -4
                        i32.add
                        local.set $stackPointer

                        ;; load value at stackpointer                    
                        local.get $stackPointer
                        i32.load

                        ;; add and and store in temp
                        i32.add
                        local.set $temp

                        ;; stack[$stackPointer] = $temp
                        local.get $stackPointer
                        local.get $temp
                        i32.store

                        br $loop
                    )
                )

                ;; handle *
                ;; $temp == -2
                local.get $temp
                i32.const -2
                i32.eq

                (if
                    (then
                        ;; load value at stackpointer
                        local.get $stackPointer
                        i32.load

                        ;; $stackPointer -= 4
                        local.get $stackPointer
                        i32.const -4
                        i32.add
                        local.set $stackPointer

                        ;; load value at stackpointer  
                        local.get $stackPointer
                        i32.load

                        ;; mul and and store in temp
                        i32.mul
                        local.set $temp

                        ;; stack[$stackPointer] = $temp
                        local.get $stackPointer
                        local.get $temp
                        i32.store

                        br $loop
                    )
                )

                ;; stackPointer += 4  
                local.get $stackPointer
                i32.const 4
                i32.add
                local.set $stackPointer

                ;; stack[$stackPointer] = $temp
                local.get $stackPointer
                local.get $temp
                i32.store 

                br $loop
            )
        
        )

        ;; $stackPointer (size of stack )
        local.get $stackPointer
    )
    (export "execute" (func $execute))
)
