uses CRT, STACKF, CLICK_HANDLER;

procedure main();

    var st: stack_t;

    begin
        st := stack_init();

        write('> ');

        repeat
            if (KEYPRESSED) then 
                begin 
                    clrscr();
                    write('> ');
                    handle_click(st);
                    writeln(stack_to_string(st));
                end;
        until(user_click.CLICK_CHAR = #13);

        stack_remove(st);
    end;

// uses CRT;

// procedure main();

//     var c: char;

//     begin
//         c := 'a';

//         repeat
//             if (KEYPRESSED) then 
//                 begin 
//                     c := readkey();
//                     writeln(ord(c));
//                 end;
//         until (c = 'q'); 
//     end;

begin
    main();
end.