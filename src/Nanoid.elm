module Nanoid exposing (Nanoid, nanoid, generator, nanoidWithOptions, toString, fromString)

{-| This library can be used to generate [nanoids][nanoid] in elm, which can be more URL
friendly than UUIDs.

@docs Nanoid, nanoid, generator, nanoidWithOptions, toString, fromString

[nanoid]: https://github.com/ai/nanoid

-}

import Array exposing (Array)
import Bitwise
import Random
import String


{-| Nanoid type. Represents a generated nanoid.
-}
type Nanoid
    = Nanoid String


{-| Creates a nanoid from a given list of integers. Generally you want to create
a randomness pool in JS using something like `Array.from(crypto.getRandomValues(new Uint8Array(21*21*7)))`.
See the examples on how to do this properly. Most nanoids consist of 21 bytes.

    nanoid [ 0, 1, 2 ] == "abc"

The length of the pool determines the length of the output.

-}
nanoid : List Int -> Nanoid
nanoid =
    nanoidWithOptions defaultAlphabet


{-| Generate nanoids using the standard values and elm/random

    import Random
    import Nanoid exposing (Nanoid)

    Random.step Nanoid.generator (Random.initialSeed 0) == "qBrbY8E1PkuPSRjijxsab"

-}
generator : Random.Generator Nanoid
generator =
    Random.list 21 (Random.int 0 0x001FFFFFFFFFFFFF)
        |> Random.map nanoid


{-| Generate a nanoid using a custom charmap.

    import Array

    nanoidWithOptions (Array.fromList ['a', 'b', 'c', 'd']) [1, 2, 3] == "abc"

-}
nanoidWithOptions : Array Char -> List Int -> Nanoid
nanoidWithOptions alphabet_ pool =
    nanoidHelper (Array.length alphabet_ - 1) alphabet_ pool
        |> String.fromList
        |> Nanoid


{-| String representation of a nanoid.
-}
toString : Nanoid -> String
toString (Nanoid s) =
    s


{-| Construct a nanoid. Useful since nanoids are customizable with alphabets & sizes.
-}
fromString : String -> Nanoid
fromString =
    Nanoid


nanoidHelper : Int -> Array Char -> List Int -> List Char
nanoidHelper len alphabet_ pool =
    case pool of
        x :: xs ->
            let
                value =
                    Bitwise.and len x
            in
            (Array.get value alphabet_
                |> Maybe.withDefault ' '
            )
                :: nanoidHelper len alphabet_ xs

        _ ->
            []


defaultAlphabet : Array Char
defaultAlphabet =
    "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890_-"
        |> String.toList
        |> Array.fromList
