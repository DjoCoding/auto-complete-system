unit QUEUEF;

interface

    uses TREEF;

    const MAX_SIZE = 100;

    type 
        queue_type = record 
            nodes: array[1..MAX_SIZE] of node_t;
            back: integer;
        end;
    
        queue_t = ^queue_type;

    procedure queue_init();
    procedure queue_remove();

    procedure enqueue(node: node_t);
    function dequeue(): node_t;

    function queue_empty(): boolean;
    function queue_full(): boolean;

    var queue: queue_t;

implementation

function queue_full(): boolean;

    begin
        queue_full := (queue^.back = MAX_SIZE); 
    end;

function queue_empty(): boolean;

    begin 
        queue_empty := (queue^.back = 0);
    end;

procedure queue_remove();

    begin
        dispose(queue);
        queue := NIL; 
    end;

procedure queue_init();

    begin 
        queue_remove();
        new(queue);
        queue^.back := 0;
    end;

procedure enqueue(node: node_t);

    begin
        if (queue_full()) then 
            begin   
                writeln('[QUEUE] queue is FULL!');
                exit();
            end;
        
        inc(queue^.back);
        queue^.nodes[queue^.back] := node;
    end;

function dequeue(): node_t;

    var i: integer;
    
    begin 
        dequeue := queue^.nodes[1];

        dec(queue^.back);

        for i := 1 to queue^.back do 
            queue^.nodes[i] := queue^.nodes[i + 1];        
    end;

begin 
end.