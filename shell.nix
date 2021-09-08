 
{ pkgs ? import <nixpkgs> {} }:

with pkgs;

let
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  inherit (lib) optional optionals;

  #erlang = beam.interpreters.erlangR22;
  #elixir = beam.packages.erlangR22.elixir_1_10;
  #rebar = beam.packages.erlangR22.rebar;
  #rebar3 = beam.packages.erlangR22.rebar3;

  # https://search.nixos.org/packages
  elixir = unstable.elixir;
  #erlang = unstable.erlang;

  # TODO: check again it
  # rebar is installed from setup script
  # as it seems that these are not recognized
  #rebar = unstable.rebar3;

  # https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#elixirls
  # https://github.com/elixir-lsp/elixir-ls#building-and-running
  elixir_ls = unstable.elixir_ls;

  nodejs = nodejs-12_x;

  postgresql = unstable.postgresql_14;

in

mkShell {
  buildInputs = [ elixir elixir_ls nodejs postgresql ];
  # Live Reloading. As we change our views or assets,
  # it automatically reloads the page in the browser
  ++ optional stdenv.isLinux libnotify # For ExUnit Notifier on Linux
  ++ optional stdenv.isLinux inotify-tools # For file_system on Linux
  ++ optional stdenv.isDarwin terminal-notifier # For ExUnit Notifier on macOS
  ++ optionals stdenv.isDarwin (with darwin.apple_sdk.frameworks; [
    # For file_system on macOS
    CoreFoundation
    CoreServices
  ]);

  shellHook = ''
    
    # https://ghedam.at/15443/a-nix-shell-for-developing-elixir
    # this allows mix to work on the local directory
    mkdir -p .nix-mix
    mkdir -p .nix-hex

    export MIX_HOME=$PWD/.nix-mix
    export HEX_HOME=$PWD/.nix-hex
    export PATH=$MIX_HOME/bin:$PATH
    export PATH=$HEX_HOME/bin:$PATH
    # https://github.com/fly-apps/hello_elixir-dockerfile/blob/main/Dockerfile
    export MIX_ENV=dev #prod

    # livebook
    #PATH=$HOME/.../elixir/tests/.../.nix-mix/escripts:$PATH    

    # https://ejpcmac.net/blog/using-nix-in-elixir-projects/
    # Put the PostgreSQL databases in the project diretory.
    export PGDATA="$PWD/db"
    
    # https://github.com/elixir-lang/elixir/wiki/FAQ#31-how-to-have-my-iex-session-history-to-be-persistent-over-different-iex-sessions
    # https://hexdocs.pm/iex/IEx.html#module-shell-history
    export ERL_AFLAGS="-kernel shell_history enabled"

    # https://elixirforum.com/t/compilation-warnings-clause-cannot-match-in-mix-and-otp-tutorial/25114/9
    unset $ERL_LIBS
    
    export LANG=en_US.UTF-8

    source ./aliases
    source ./setup
  '';
}
