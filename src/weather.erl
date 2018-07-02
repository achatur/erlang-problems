-module(weather).
-export([forecast/1]).

%%forecast(_) -> ok.

forecast(Cities) ->
  Self = self(),
  [spawn(fun() -> Self ! weather_api:get_weather(City) end) || City <- Cities],
  loop(length(Cities), []).

loop(0, R) ->
  lists:reverse(R);
loop(N, R) ->
  receive
    {weather, {current,  _, _}, {forecast,  _, Forecast}} ->
      loop(N - 1, [Forecast | R])
  end.