-module(weather).
-export([forecast/1]).

%%forecast(_) -> ok.

forecast(Cities) ->
  Self = self(),
  [spawn(fun() -> Self ! weather_api:get_weather(City) end) || City <- Cities],
  loop(length(Cities), []).

loop(0, Rendered) ->
  lists:reverse(Rendered);
loop(N, Rendered) ->
  receive
    {weather, {current,  _, _}, {forecast,  _, Forecast}} ->
      loop(N - 1, [Forecast | Rendered])
  end.