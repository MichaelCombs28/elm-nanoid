# elm-nanoid

<img src="https://ai.github.io/nanoid/logo.svg" align="right"
     alt="Nano ID logo by Anton Lovchikov" width="180" height="94">

[This package](https://package.elm-lang.org/packages/MichaelCombs28/elm-nanoid/latest/) is an Elm
implementation of [ai/nanoid](https://github.com/ai/nanoid).

Features of this nanoid package are:

- Generator using [elm/random](https://package.elm-lang.org/packages/elm/random/latest/)
- Support for direct pool arguments using something like
  [elm-random-pcg-extended](https://package.elm-lang.org/packages/NoRedInk/elm-random-pcg-extended/latest/)
- Customizable alphabet and ID size

## Install

```
elm install MichaelCombs28/elm-nanoid
```

## Example

```elm
import Nanoid
import Random

...

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    GenerateNanoid ->
      (model, Random.generate NanoidGenerated Nanoid.generator)

```

For more complete examples, see the [examples](examples/Main.elm) folder.

## Security

**See [comparison of Nano ID and UUID(V4)](https://github.com/ai/nanoid/blob/main/README.md#comparison-with-uuid):**

> "Nano ID is quite comparable to UUID v4 (random-based). It has a similar number of random bits in the ID (126 in Nano ID and 122 in UUID), so it has a similar collision probability -- **for there to be a one in a billion chance of duplication, 103 trillion version 4 IDs must be generated**"

With Elm, there are always randomness concerns which is the cost for reliability.
Flags generated with a few bytes of randomness passed to a decent PCG library should
cover most usecases.

[More on PCG Here](https://www.pcg-random.org/)
