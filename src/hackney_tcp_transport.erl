-module(hackney_tcp_transport).
-export([connect/3,
         recv/2, recv/3,
         send/2,
         setopts/2,
         controlling_process/2,
         peername/1,
         close/1,
         sockname/1]).

connect(Host, Port, Opts) when is_list(Host), is_integer(Port) ->
	gen_tcp:connect(Host, Port,
		Opts ++ [binary, {active, false}, {packet, raw}]).

recv(Socket, Length) ->
    recv(Socket, Length, infinity).

%% @doc Receive a packet from a socket in passive mode.
%% @see gen_tcp:recv/3
-spec recv(inet:socket(), non_neg_integer(), timeout())
	-> {ok, any()} | {error, closed | atom()}.
recv(Socket, Length, Timeout) ->
	gen_tcp:recv(Socket, Length, Timeout).


%% @doc Send a packet on a socket.
%% @see gen_tcp:send/2
-spec send(inet:socket(), iolist()) -> ok | {error, atom()}.
send(Socket, Packet) ->
	gen_tcp:send(Socket, Packet).

%% @doc Set one or more options for a socket.
%% @see inet:setopts/2
-spec setopts(inet:socket(), list()) -> ok | {error, atom()}.
setopts(Socket, Opts) ->
	inet:setopts(Socket, Opts).

%% @doc Assign a new controlling process <em>Pid</em> to <em>Socket</em>.
%% @see gen_tcp:controlling_process/2
-spec controlling_process(inet:socket(), pid())
	-> ok | {error, closed | not_owner | atom()}.
controlling_process(Socket, Pid) ->
	gen_tcp:controlling_process(Socket, Pid).

%% @doc Return the address and port for the other end of a connection.
%% @see inet:peername/1
-spec peername(inet:socket())
	-> {ok, {inet:ip_address(), inet:port_number()}} | {error, atom()}.
peername(Socket) ->
	inet:peername(Socket).

%% @doc Close a TCP socket.
%% @see gen_tcp:close/1
-spec close(inet:socket()) -> ok.
close(Socket) ->
	gen_tcp:close(Socket).

%% @doc Get the local address and port of a socket
%% @see inet:sockname/1
-spec sockname(inet:socket())
	-> {ok, {inet:ip_address(), inet:port_number()}} | {error, atom()}.
sockname(Socket) ->
	inet:sockname(Socket).