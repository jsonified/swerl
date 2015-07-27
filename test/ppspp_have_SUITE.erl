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

%% @doc Library for PPSPP over UDP, aka Swift protocol
%% <p>This module implements a library of functions necessary to
%% handle the wire-protocol of PPSPP over UDP, including
%% functions for encoding and decoding messages.</p>
%% @end

-module(ppspp_have_SUITE).
-include("swirl.hrl").
-include_lib("common_test/include/ct.hrl").

-export([all/0]).
-export([have/1]).

-spec all() -> [atom()].
all() -> [have].

-spec have(any()) -> [any()].
have(_Config) ->
    ct:comment("have: ensure parsing have() does not consume additional data"),
    %% have() is a thin wrapper around chunk handling
    Method = chunk_32bit_chunks,
    Garbage = crypto:strong_rand_bytes(10),
    Chunks = <<15:64, Garbage/binary>>,
    Expected = { #{have => #{chunk_spec => {chunk_32bit_chunks,0,15} }},
                 Garbage},
    Expected = ppspp_have:unpack(Method, Chunks).
