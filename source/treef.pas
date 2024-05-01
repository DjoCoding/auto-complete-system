unit TREEF;

interface   

    uses BUFFERF, PFILE; 

    type node_t = ^node_type;
        node_type = record 
            value: char;
            is_end: boolean;
            child_node, next_node: node_t;
        end;
    
    procedure root_remove();
    procedure root_init();

    procedure add_word_to_tree(word: string);
    procedure dfs_root();

    procedure dfs_prefix(prefix: string);

    procedure reset_tree_from_file(file_path: string);
    procedure append_tree_from_file(file_path: string);

    var root: node_t;

implementation

function node_create(value: char; is_end: boolean): node_t;

    var result: node_t;

    begin 
        new(result);
        result^.value := value;
        result^.is_end := is_end;
        result^.child_node := NIL;
        result^.next_node := NIL;
        node_create := result;
        result := NIL;
    end;

function get_child_node(node: node_t; value: char): node_t;
    
    var 
        current: node_t;

    begin
        current := node^.child_node;
        
        while (current <> NIL) do 
            if (current^.value = value) then break
            else 
                current := current^.next_node;
        
        get_child_node := current;
    end;

// this function will returns the new node after the insertion!
function add_node_to_tree(node: node_t; value: char): node_t;

    var new_node: node_t;

    begin 
        new_node := node_create(value, FALSE); // suppose it's not the end of the word!
        new_node^.next_node := node^.child_node;
        node^.child_node := new_node;
        add_node_to_tree := new_node;
        new_node := NIL; 
    end;

procedure add_word_to_tree(word: string);

    var i, size: integer;
        child_node, current: node_t;

    begin
        current := root;
        size := length(word);

        for i := 1 to size do 
            begin
                child_node := get_child_node(current, word[i]);
                if (child_node = NIL) then 
                    child_node := add_node_to_tree(current, word[i]);
                current := child_node;
            end;
        
        current^.is_end := TRUE;
        current := NIL;
        child_node := NIL;
    end;

function get_prefix_in_tree(prefix: string): node_t;

    var current: node_t;
        size, i: integer;

    begin
        current := root;
        i := 1;
        size := length(prefix);

        while ((i <= size) and (current <> NIL)) do 
            begin
                current := get_child_node(current, prefix[i]);
                inc(i); 
            end; 
        
        get_prefix_in_tree := current;
    end;


procedure dfs(buffer: buffer_t; node: node_t);

    var current: node_t;

    begin
        if (node = NIL) then exit();

        current := node^.child_node;

        while (current <> NIL) do 
            begin
                push(buffer, current^.value);
                
                if (current^.is_end) then 
                    write_buffer(buffer);
                
                dfs(buffer, current);

                pop(buffer);

                current := current^.next_node; 
            end;
    end;

procedure dfs_root();

    var buffer: buffer_t; 

    begin 
        buffer := buffer_init();
        dfs(buffer, root);
        writeln();
        buffer_remove(buffer);
    end;

procedure dfs_prefix(prefix: string);

    var buffer: buffer_t;
        node: node_t;

    begin
        node := get_prefix_in_tree(prefix);
        buffer := buffer_init();

        push_string(buffer, prefix);
        dfs(buffer, node);
        buffer_remove(buffer);
    end;

procedure remove_sub_tree(node: node_t);

    var next, current: node_t;

    begin
        if (node = NIL) then exit();

        current := node^.child_node;
        while (current <> NIL) do 
            begin
                next := current^.next_node;
                remove_sub_tree(current);
                dispose(current);
                current := next; 
            end;
    end;

procedure root_remove();

    begin 
        remove_sub_tree(root);
        dispose(root);
        root := NIL;
    end;

procedure root_init();

    begin
        root_remove();
        root := node_create('r', FALSE); 
    end;

procedure reset_tree_from_file(file_path: string);

    begin
        root_remove();
        append_tree_from_file(file_path);
    end;

procedure append_tree_from_file(file_path: string);

    var WORDS_FILE: TEXT;
        word: string;

    begin
        assign(WORDS_FILE, file_path); 
        open_file(WORDS_FILE, 'r');

        while (not EOF(WORDS_FILE)) do 
            begin 
                readln(WORDS_FILE, word);
                add_word_to_tree(word);
            end;

        close(WORDS_FILE);
    end;


begin 
end.

