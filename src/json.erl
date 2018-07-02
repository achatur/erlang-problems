-module(json).
-export([render/1]).

%%render(_) -> ok.

render({List}) when is_list(List) ->
  "{" ++ erl_list_render(List) ++ "}";
render({Key, JsonValue}) when is_atom(Key) ->
  "\"" ++ atom_to_list(Key) ++ "\":" ++ render(JsonValue);
render(JsonValue) when is_binary(JsonValue) ->
  "\"" ++ binary_to_list(JsonValue) ++ "\"";
render(JsonValue) when is_integer(JsonValue) ->
  integer_to_list(JsonValue);
render(List) when is_list(List) ->
  "[" ++ erl_list_render(List) ++ "]".

erl_list_render([]) ->
  "";
erl_list_render([Expected]) ->
  render(Expected);
erl_list_render([Expected | Rendered]) ->
  render(Expected) ++ "," ++ erl_list_render(Rendered).