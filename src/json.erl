-module(json).
-export([render/1]).

%%render(_) -> ok.

render({L}) when is_list(L) ->
  "{" ++ erl_list_render(L) ++ "}";
render({Key, JValue}) when is_atom(Key) ->
  "\"" ++ atom_to_list(Key) ++ "\":" ++ render(JValue);
render(JValue) when is_binary(JValue) ->
  "\"" ++ binary_to_list(JValue) ++ "\"";
render(JValue) when is_integer(JValue) ->
  integer_to_list(JValue);
render(L) when is_list(L) ->
  "[" ++ erl_list_render(L) ++ "]".

erl_list_render([]) ->
  "";
erl_list_render([E]) ->
  render(E);
erl_list_render([E | R]) ->
  render(E) ++ "," ++ erl_list_render(R).