deck = for suit <- ~w(H C D S), face <- [2,3,4,5,6,7,8,9,10,"J","Q","K","A"],
  do: {suit, face}

hand = deck |> Enum.shuffle |> Enum.take(13)
deal_hands = deck |> Enum.shuffle |> Enum.chunk(4)

IO.inspect deal_hands

