module DescendingOrder where
    descendingOrder :: Integer -> Integer
    descendingOrder n = (read.sort (>).show) n 

    sort :: (Ord a) => (a -> a -> Bool) -> [a] -> [a]
    sort _ [] = []
    sort _ [x] = [x]
    sort predicate xs = merge predicate (sort predicate ys) (sort predicate zs)
                where (ys, zs) = halve xs
    halve xs = (take n xs, drop n xs)
                where n = length xs `div` 2

    merge :: (Ord a) => (a -> a -> Bool) -> [a] -> [a] -> [a]
    merge _ [] ys = ys
    merge _ xs [] = xs
    merge predicate xs'@(x:xs) ys'@(y:ys)
        | predicate x y         = x:merge predicate xs ys'
        | otherwise             = y:merge predicate xs' ys