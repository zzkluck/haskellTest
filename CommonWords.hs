module CommonWords(commonWords) where
    import Data.Char(toLower)
    import Data.List(sort)

    commonWords :: Int->String->String
    commonWords n = concat . map showRun . take n .
                    sortRuns . countRuns . sort . 
                    words . map toLower

    showRun :: (Int,String) ->  String
    showRun (n,word) = word ++ ": " ++ show n ++ "\n"

    countRuns :: [String] -> [(Int,String)]
    countRuns [] = []
    countRuns (w:ws) = (1 + length us, w):countRuns vs
                        where (us, vs) = span (==w) ws

    sortRuns :: [(Int,String)] -> [(Int,String)]
    sortRuns = reverse . sort