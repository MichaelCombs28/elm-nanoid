module TestNanoid exposing (tests)

import Array
import Expect
import Nanoid
import Random
import Test exposing (Test, describe, test)


tests : Test
tests =
    describe "Nanoid module"
        [ test "nanoidFromPool" <|
            \_ ->
                Nanoid.nanoid
                    [ 470295175863548
                    , 1739789926246453
                    , 6775084291595227
                    , 273749781785988
                    , 653506710845878
                    , 1447435509359672
                    , 909818424220015
                    , 7778742143142836
                    , 6000277274794751
                    , 2319111034304719
                    , 2968363036305331
                    , 1664600641643803
                    , 6352492719724658
                    , 4830967678166060
                    , 476929913281812
                    , 4669754982027403
                    , 2566767661580489
                    , 6066463079585998
                    , 3616922333804955
                    , 6494370540915707
                    , 6275707332632510
                    ]
                    |> Nanoid.toString
                    |> Expect.equal "92Be35V1-pZBYSuljoB8_"
        , test "generator" <|
            \_ ->
                Random.step Nanoid.generator (Random.initialSeed 1)
                    |> Tuple.first
                    |> Nanoid.toString
                    |> String.length
                    >> Expect.equal 21
        , test "doc test 1" <|
            \_ ->
                Nanoid.nanoid [ 0, 1, 2 ]
                    |> Nanoid.toString
                    |> Expect.equal "abc"
        , test "doc test 2" <|
            \_ ->
                Nanoid.nanoidWithOptions (Array.fromList [ 'a', 'b', 'c', 'd' ]) [ 0, 1, 2 ]
                    |> Nanoid.toString
                    |> Expect.equal "abc"
        ]
