unit HANDLERF;

interface

    uses CRT, TREEF, STACKF, CLICK_HANDLER;

    procedure run();

implementation

procedure run();

    var 
        st: stack_t;
        input: string;

    begin
        input := '';
        st := stack_init();

        write('> ');

        repeat
            if (KEYPRESSED) then 
                begin 
                    clrscr();
                    write('> ');
                    handle_click(st);
                    input := stack_to_string(st);
                    writeln(input);
                    dfs_prefix(input);
                end;
        until(user_click.CLICK_CHAR = #13);

        stack_remove(st);
    end;


begin 
end.