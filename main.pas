uses TREEF, HANDLERF;

procedure usage();

    begin 
        writeln();
    end;

function handle_input(): boolean;

    var i: integer;

    begin
        if (paramCOUNT = 0) then 
            begin
                usage();
                writeln('ERROR: NO INPUT FILE PROVIDED!'); 
                handle_input := FALSE;
                exit();
            end;

        for i := 1 to paramCOUNT do    
            append_tree_from_file(paramSTR(i));
        
        handle_input := TRUE;
    end;

procedure main();

    begin 
        root_init();
        if (not handle_input()) then exit();
        run();
        root_remove();
    end;

begin
    main();
end.