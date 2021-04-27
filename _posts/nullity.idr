
total
ifNull : (str: Maybe String) -> ((s: String) -> str = Just s -> a) -> (str = Nothing -> a) -> a
ifNull Nothing  _ if_else = if_else Refl
ifNull (Just s) if_then _ = if_then s Refl

total
foo : Maybe String -> IO ()
foo mstr = print $ ifNull mstr
                          (\_  => \ev => case  of )
                          (\ev => Z)

