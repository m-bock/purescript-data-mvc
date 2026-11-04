build-strict:
    spago build --strict

build:
    spago build

test-strict:
    spago test --strict

test:
    spago test

clean:
    rm -rf .spago output .psa-stash

ide:
    spago test --json-errors

format:
    purs-tidy format-in-place 'src/**/*.purs'
    purs-tidy format-in-place 'test/**/*.purs'

check-format:
    purs-tidy check 'src/**/*.purs'
    purs-tidy check 'test/**/*.purs'

check-git-clean:
    [ -z "$(git status --porcelain)" ]

ci: check-format build-strict test-strict check-git-clean

ci-nix:
    nix develop --command just ci

suggest-list:
    just ide 2>&1 | ps-suggest --list

suggest-apply:
    just ide 2>&1 | ps-suggest --apply

gen-purs-docs:
    spago docs
