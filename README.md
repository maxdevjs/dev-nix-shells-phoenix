# nix-shell for Phoenix

> WIP

## What is it?

A [nix-shell](https://nixos.org/manual/nix/stable/#description-13) template to set a [Phoenix](phoenixframework.org/) development environment up with [direnv](https://github.com/direnv/direnv) integration (if installed).

Built gathering inspiration from several [sources](#resources), it makes available:

- `unstable.`[elixir](elixir-lang.org/)
- `unstable.`[elixir_ls](https://github.com/elixir-lsp/elixir-ls) ([LSP](https://microsoft.github.io/language-server-protocol/))
- nodejs-12_x for [WebPack](https://webpack.js.org/) swing
- [rebar3](https://github.com/erlang/rebar3) via `setup` script: [erlang](https://www.erlang.org/) build tool that makes it easy to compile and test [erlang](https://www.erlang.org/) applications and releases
  - currently installed from the `setup` script: check [TODO](#todo)
- [Phoenix](phoenixframework.org/) version `1.5.9` installed via `setup` script
- `unstable.`[postgresql_14](https://www.postgresql.org/) setup
  - TODO: check/complete [PostgreSQL](https://www.postgresql.org/) section

### Working with a local PostgreSQL instance

```yaml
initdb --no-locale --encoding=UTF-8
pg_ctl -l "$PGDATA/server.log" start
createuser postgres --createdb
mix ecto.setup
```

Because we are too lazy to run all these commands by hand each time Iwe need to setup a project and because automation is good: [ejpcmac](https://github.com/ejpcmac)'s [Setup script for Phoenix projects using Nix and PostgreSQL](https://gist.github.com/ejpcmac/c09d47dfa627c9503c01cdf0779af0f7)

My [fork](https://gist.github.com/maxdevjs/0f75f5b7d03b6afae21b7282166cf7c5) of [ejpcmac](https://github.com/ejpcmac)'s script (never knows).

To stop our local PostgreSQL instance:

```yaml
pg_ctl stop
```

## Resources

[localhost:4000](http://localhost:4000/)

### Direnv

- [Automating development environment set-up with Direnv](http://www.futurile.net/2016/02/03/automating-environment-setup-with-direnv/)
- [More prac­ti­cal direnv](https://rnorth.org/more-practical-direnv/)
  - [rnorth/.direnvrc](https://gist.github.com/rnorth/0fd5048da85957da39c17bd49c4ca922)

### Miscellaneous

- [About using Nix in my development workflow - Jean-Philippe Cugnet - Medium](https://medium.com/@ejpcmac/about-using-nix-in-my-development-workflow-12422a1f2f4c)
- [Phoenix Installation Guide](https://hexdocs.pm/phoenix/installation.html)
- [Up and Running](https://hexdocs.pm/phoenix/up_and_running.html)

### Nix

- [Using Nix in Elixir projects](https://ejpcmac.net/blog/using-nix-in-elixir-projects/)

## TODO

- [ ] envrc_to_check
- [ ] setup_to_check

- [ ] `Could not find "rebar3", which is needed to build dependency :ranch`?
  - currently installed from the `setup` script
- [ ] check [.envrc for Phoenix projects using Nix and PostgreSQL](https://gist.github.com/ejpcmac/32d3480aec2bcb941f95fab0477617d3#file-envrc-L86-L89)
- [ ] automatically stop local PostgreSQL instance when leaving the environment
  - [Unload hook #129](https://github.com/direnv/direnv/issues/129) | [Include explict 'direnv unload' #260](https://github.com/direnv/direnv/issues/260)
- [lorri](https://github.com/nix-community/lorri) integration
- [niv](https://github.com/joefiorini/niv)
- ...
