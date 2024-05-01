unit HANDLERF;

interface
    
    uses ENTRYF, INPUTF, CRT, TREEF, BUFFERF, CLICKF;

    procedure run();

implementation

procedure run();

    var 
        HANDLING_RESULT: Boolean;
        buffer: buffer_t;

    begin
        // initializing 
        root_init();
        buffer := buffer_init();

        entry();
        write('> ');
        HANDLING_RESULT := FALSE;

        repeat
            if (KEYPRESSED) then 
                begin 
                    clrscr();
                    entry();
                    write('> ');
                    handle_click(buffer);
                    writeln(buffer_to_string(buffer));
                    HANDLING_RESULT := handle_user_input(buffer);
                end;
        until(HANDLING_RESULT); 

        // freeing the memory
        buffer_remove(buffer);
        root_remove();
    end;


begin 
end.