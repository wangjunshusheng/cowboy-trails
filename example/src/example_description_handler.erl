-module(example_description_handler).

-include_lib("mixer/include/mixer.hrl").
-mixin([
        {example_default,
         [
          init/3,
          rest_init/2,
          content_types_accepted/2,
          content_types_provided/2,
          resource_exists/2
         ]}
       ]).

-export(
  [
   allowed_methods/2,
   handle_get/2
  ]).

%% cowboy
allowed_methods(Req, State) ->
    {[<<"GET">>], Req, State}.

%% internal
handle_get(Req, State) ->
  Body = trails:all(),
  lager:info("~p", [Body]),
  Req1 = cowboy_req:set_resp_header(<<"content-type:">>, "Erlang Data", Req),
  {io_lib:format("~p~n", [Body]), Req1, State}.
