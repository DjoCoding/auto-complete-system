unit INPUTF;

interface

    uses CRT, PARSERF, ERRORF, CLICKF, GRAPHF, SYSUTILS, BUFFERF, TREEF, STRING_VIEWF, TOKENIZERF;

    function handle_user_input(buffer: buffer_t): boolean;

    var current_graph_directory: string = './';
        current_directory: string = './';

implementation

procedure handle_show_command(parser: parser_t);

    var current: token_t;

    begin
        if (not end_tokens(parser)) then 
            begin
                current := parser_consume(parser);
                case current^.value of 
                    '-c':   // current files directory!   
                        begin 
                            writeln('FILES AT: ', current_directory);
                            exit();
                        end;
                    '-g':  // current graphs directory!
                        begin
                            writeln('GRAPHS AT: ', current_graph_directory);
                            exit(); 
                        end;
                else 
                    begin 
                        usage();
                        error_write('ERROR: TOKEN ' + current^.value + ' NOT EXPECTED!');
                        exit();
                    end; 
                end;
            end;
        
        dfs_root();
        current := NIL;
    end;

procedure handle_add_command(parser: parser_t);

    var current: token_t;
        file_path: string;

    begin 
        writeln();

        if (end_tokens(parser)) then 
            begin
                usage();
                error_write('ERROR: EXPECTED FILE PATHS!');
                exit(); 
            end;

        while (not end_tokens(parser)) do 
            begin
                current := parser_consume(parser);
                if (current^._type = COMMAND_TYPE) then 
                    begin
                        usage();
                        error_write('ERROR: EXPECTED FILE PATH BUT GOT COMMAND: ' + current^.value);
                        exit();
                    end; 

                file_path := './' + current_directory + '/' + current^.value;

                if (FileExists(file_path)) then 
                    begin 
                        append_tree_from_file(file_path);
                        writeln('FILE WITH PATH: ' + file_path + ' ADDED SUCCESSFULLY!');
                    end
                else 
                    begin
                        usage();
                        writeln();
                        error_write('ERROR: FILE NAMED: ' + file_path + ' IS NOT FOUND!');
                        exit(); 
                    end;
            end; 
    end;

procedure handle_graph_command(parser: parser_t);

    var file_path: string;
        current: token_t;

    begin 
        if (end_tokens(parser)) then 
            begin
                usage();
                error_write('ERROR: FILE NAME EXPECTED!');
                exit(); 
            end;
        
        current := parser_consume(parser);

        if (current^._type = COMMAND_TYPE) then 
            begin
                usage();
                error_write('ERROR: EXPECTED FILE NAME BUT GOT COMMAND: ' + current^.value);
                exit();  
            end;

        if (not end_tokens(parser)) then 
            begin
                usage();
                error_write('ERROR: EXPECTED ONE FILE PATH, BUT FOUND MORE!');
                exit(); 
            end;
        
        if (not DirectoryExists(current_graph_directory)) then 
            begin 
                usage();
                error_write('ERROR: DIRECTORY ' + current_graph_directory + ' NOT FOUND!');
                exit(); 
            end;

        file_path := './' + current_graph_directory + '/' + current^.value;
        get_graph(file_path);

        writeln('[GRAPH MAKER] THE GRAPH FILE IS NOW AVAILABLE IN FILE: ', file_path);
        writeln();

        current := NIL;
    end;


procedure handle_directory_command(parser: parser_t);

    var dir_name: string;
        current: token_t;

    begin
        if (end_tokens(parser)) then 
            begin
                usage();
                error_write('ERROR: MORE TOKENS EXPECTED!');
                exit(); 
            end;

        current := parser_consume(parser);
        
        // add the options for the graph directory -g and the current directory -c

        if (current^.value[1] <> '-') then 
            begin
                usage();
                error_write('ERROR: OPTION EXPECTED!');
                exit(); 
            end;
        
        if (end_tokens(parser)) then 
            begin 
                usage();
                error_write('ERROR: FILE NAME EXPECTED!');
                exit(); 
            end;
        
        dir_name := parser_consume(parser)^.value;

        case (current^.value) of 
            '-g':
                current_graph_directory := dir_name;
            '-c':   
                current_directory := dir_name;
            else 
                begin
                    usage();
                    error_write('ERROR: ' + current^.value +' IS NOT AN OPTION!');
                    exit(); 
                end;
        end;

        current := NIL;
    end;

procedure handle_no_command_input(input: string);

    begin
        if (user_click.CLICK_CHAR = #13) then 
            user_click.CLICK_CHAR := #4;     // that will be the signal to quit (press ENTER);

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
                handle_add_command(parser);
            ':show': 
                handle_show_command(parser);
            ':graph':
                handle_graph_command(parser);
            ':dir':
                handle_directory_command(parser);
            ':h':
                usage();
            
            else 
                begin
                    usage();
                    error_write('ERROR: COMMAND ' + current^.value + ' NOT FOUND!'); 
                end;
        end;  

        sv_remove(sv);
        parser_remove(parser);
        current := NIL;
    end;

function handle_user_input(buffer: buffer_t): boolean;

    var input: string;

    begin
        input := buffer_to_string(buffer);
        handle_user_input := FALSE;

        if (input[1] = ':') then 
            if (user_click.CLICK_CHAR = #13) then  // if user click = ENTER => handle the command!
                begin   
                    clrscr();
                    writeln('> ');
                    if (input = ':q') then 
                        begin 
                            handle_user_input := TRUE;
                            writeln('[HANDLER] QUITTING!');
                            exit();
                        end;
                        
                    handle_command_input(input);
                    buffer_reset(buffer);
                end
            else 
                exit()
        else
            handle_no_command_input(input);

    end;

begin 
end.