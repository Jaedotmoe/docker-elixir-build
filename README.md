# Docker Elixir Build Image Base

This builds a Docker image that can be used to build Elixir (and Erlang)
projects.

## Contents

* Elixir 1.4.4
* Erlang 19.2
* `rebar`
* `hex`
* `make`, `git`, `wget`

## Expectations

* Mounts `/project` volume from host.
* Mounts `/release` volume from host.

These are made as a convenience, so that running a build, with build input (source) and build output
to the local host filesystem is easy.

## Example

Assuming Distillery's `rel/config.exs` is configured for a stand-alone ERTS release as so:

```
environment :docker do
  set dev_mode: false
  set include_erts: true
  set include_src: false
  set cookie: :crypto.hash(:sha256, :crypto.rand_bytes(25)) |> Base.encode16 |> String.to_atom
  set output_dir: "/release"
end
```

You can build the release inside the Docker container, with output to `.release` with:

```
docker run --rm -v $(pwd):/project -v $(pwd)/.release:/release --env MIX_ENV=docker \
nexus.in.ft.com:5000/membership/elixir-build:latest mix release --env=docker
```

The packaged stand-alone build in `.release` can then be copied into a minimal Alpine image.
