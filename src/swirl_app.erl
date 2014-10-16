%% -*- tab-width: 4;erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ft=erlang ts=4 sw=4 et
%% Licensed under the Apache License, Version 2.0 (the "License"); you may not
%% use this file except in compliance with the License. You may obtain a copy of
%% the License at
%%
%%   http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
%% WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
%% License for the specific language governing permissions and limitations under
%% the License.

-module(swirl_app).
-include("swirl.hrl").

-ifdef(TEST).
-include_lib("eunit/include/eunit.hrl").
-spec test() -> term().
-endif.

-behaviour(application).

%% api
-export([version/0]).

%% callbacks
-export([start/2,
         stop/1]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% api

-spec version() -> {string(), string()}.
version() ->
    {ok, Version} = application:get_key(swirl, vsn),
    {?PPSPP_RELEASE, Version}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% callbacks

%% used by application:start/1
-spec start(_ ,_ ) -> {ok, pid()} | {error,_ }.
start(_Type, _Start_Args) ->
    {Protocol, Version} = version(),
    ?INFO("swirl: protocol ~s~n", [Protocol]),
    ?INFO("swirl: version #~s~n", [Version]),
    swirl_sup:start_link().

-spec stop(_) -> ok.
stop(_State) ->
    ok.
