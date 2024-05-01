unit HANDLE_INPUT;

interface

    uses PARSERF, HANDLE_ERRORF, CLICK_HANDLER, GRAPHF, SYSUTILS, STACKF, TREEF, STRING_VIEWF, TOKENIZERF;

    procedure handle_user_input(st: stack_t);

implementation

procedure handle_show_command(parser: parser_t);

    var current: token_t;

    begin
        if (not end_tokens(parser)) then 
            begin
                current := parser_consume(parser);
                usage();
                writeln('ERROR: TOKEN ', current^.value, ' NOT EXPECTED!');
                exit(); 
            end;
        
        dfs_root();
        current := NIL;
    end;

procedure handle_add_command(parser: parser_t);

    var current: token_t;
        file_path: string;

    begin 
        if (end_tokens(parser)) then 
            begin
                usage();
                writeln('ERROR: EXPECTED FILE PATHS!');
                exit(); 
            end;

        while (not end_tokens(parser)) do 
            begin
                current := parser_consume(parser);
                if (current^._type = COMMAND_TYPE) then 
                    begin
                        usage();
                        writeln('ERROR: EXPECTED FILE PATH BUT GOT COMMAND: ', current^.value);
                        exit();
                    end; 

                file_path := current^.value;
                if (FileExists(file_path)) then 
                    append_tree_from_file(file_path)
                else 
                    begin
                        usage();
                        writeln();
                        writeln('ERROR: FILE NAMED: ', file_path, ' IS NOT FOUND!');
                        exit(); 
                    end;
            end; 
    end;

procedure handle_graph_command(parser: parser_t);

    var current: token_t;

    begin 
        if (end_tokens(parser)) then 
            begin
                usage();
                writeln('ERROR: FILE NAME EXPECTED!');
                exit(); 
            end;
        
        current := parser_consume(parser);

        if (current^._type = COMMAND_TYPE) then 
            begin
                usage();
                writeln('ERROR: EXPECTED FILE NAME BUT GOT COMMAND: ', current^.value);
                exit();  
            end;

        if (not end_tokens(parser)) then 
            begin
                usage();
                writeln('ERROR: EXPECTED ONE FILE PATH, BUT FOUND MORE!');
                exit(); 
            end;
        
        get_graph(current^.value);
    end;

procedure handle_no_command_input(input: string);


    begin
        writeln(input);
        dfs_prefix(input); 
    end;

procedure handle_command_input(input: string);

    var sv: sv_t;
        tokens: token_list;
        current: token_t;
        parser: parser_t;
    
    begin
        sv := sv_create(input);
        tokens := get_tokens(sv);

        if (tokens^.head = NIL) then 
            begin 
                sv_remove(sv);
                token_list_remove(tokens);
                exit();
            end;

        parser := parser_create(tokens); // creating the parser!
        current := parser_consume(parser); // consuming the first token! (the command token);

        case current^.value of 
            ':add': 
                begin 
                    handle_add_command(parser);
                    exit();
                end;
            ':show': 
                begin 
                    handle_show_command(parser);
                    exit();
                end;
            ':graph':
                begin 
                    handle_graph_command(parser);
                    exit();
                end;
            
            else 
                begin
                    usage();
                    writeln('ERROR: COMMAND ', current^.value, ' NOT FOUND!'); 
                    exit();
                end;
        end;  

        sv_remove(sv);
        parser_remove(parser);
        current := NIL;
    end;

procedure handle_user_input(st: stack_t);

    var input: string;

    begin
        input := stack_to_string(st);

        if (input[1] = ':') then 
            if (user_click.CLICK_CHAR = #13) then  // if user click = ENTER => handle the command!
                begin 
                    handle_command_input(input);
                    stack_reset(st);
                end
        else 
            handle_no_command_input(input);
    end;

begin 
end.