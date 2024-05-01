unit GRAPHF;

interface

    uses PFILE, TREEF, QUEUEF;

    procedure get_graph(file_path: string);

implementation

procedure get_graph(var stream: TEXT);

    var child_node: node_t;
        current: node_t;

    begin
        queue_init();
        enqueue(root);

        while (not queue_empty()) do 
            begin
                current := dequeue();
                child_node := current^.child_node;
                while (child_node <> NIL) do 
                    begin 
                        writeln(stream, current^.value, ' -- ', child_node^.value);
                        enqueue(child_node);
                        child_node := child_node^.next_node;
                    end;
            end;

        queue_remove();
    end;

procedure get_graph(file_path: string);

    var stream: TEXT;

    begin
        assign(stream, file_path);
        open_file(stream, 'w');

        writeln(stream, 'GRAPH {');
        get_graph(stream);
        writeln(stream, '}');
        
        close(stream);
    end;

begin 
end.