unit HANDLERF;

interface
    
    uses HANDLE_INPUT, CRT, TREEF, STACKF, CLICK_HANDLER;

    procedure run();

implementation

procedure run();

    var 
        st: stack_t;
        input: string;

    begin
        // initializing 
        root_init();
        st := stack_init();
        input := '';

        write('> ');
        repeat
            if (KEYPRESSED) then 
                begin 
                    clrscr();
                    write('> ');

                    handle_click(st);

                    handle_user_input(st);
                end;

        until(user_click.CLICK_CHAR = #13);

        // freeing the memory
        stack_remove(st);
        root_remove();
    end;


begin 
end.