revList :: [a] -> [a]
revList [] = []
revList (h:t) = revList t ++ [h]

dropList :: Int -> [a] -> [a]
dropList 0 list = list
dropList _ [] = []
dropList n (h:t) = dropList (n-1) t

fizzbuzz :: Int -> String
fizzbuzz a 
    | a `mod` 15 == 0 = "FizzBuzz"
    | a `mod` 3 == 0 = "Fizz"
    | a `mod` 5 == 0 = "Buzz"
    | otherwise = show a

(|>) :: a -> (a -> b) -> b
(|>) val func = func val

quicksort :: (Ord a) => [a] -> [a]
quicksort (x:xs) = [v | v <- xs, v <= x] ++ [x] ++ [v | v <- xs, v > x]

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

partition' :: (a -> Bool) -> [a] -> ([a],[a])
partition' f l = partition_' f ([],[]) l

partition_' :: (a -> Bool) -> ([a],[a]) -> [a] -> ([a],[a])
partition_' f (h,t) [] = (h,t)
partition_' f (h,t) (x:xs) 
    | f(x) = partition_' f (h, x:t) xs
    | otherwise = partition_' f (x:h, t) xs

--
-- Types
-- Int
-- Integer makes use unbounded list
-- Char
-- Bool
-- Float
-- Double

-- Here Shape is the type and Circle and Rectange are the value constructors
-- like Circle :: Float -> Float -> Float -> Shape
-- Value Constructors are functions 
data Shape = Circle Float Float Float
    | Rectangle Float Float Float Float deriving (Show, Eq)

area :: Shape -> Float
area (Circle _ _ r) = 3.1415 * r * r
area (Rectangle x1 y1 x2 y2) = abs (x1 - x2) * abs(y1 - y2)


data Vector2D = Vector2D Float Float deriving (Show, Eq)

add :: Vector2D -> Vector2D -> Vector2D
add (Vector2D x1 y1) (Vector2D x2 y2) = Vector2D (x1+x2) (y1+y2)


data MyBool = MyFalse | MyTrue deriving (Ord, Eq, Show)

class YesNo a where
    yesno :: a -> MyBool

instance YesNo Int where
    yesno 0 = MyFalse
    yesno _ = MyTrue

instance YesNo [a] where
    yesno [] = MyFalse
    yesno _ = MyTrue

instance YesNo MyBool where  
    yesno = id 

data Optional a = Empty | Some a deriving (Show, Eq)

instance Functor Optional where
    fmap f Empty = Empty
    fmap f (Some a) = Some $ f a

rpn :: (Num a, Read a) => String -> a
rpn exp = exp |> words |> foldl f [] |> head
    where f (x:y:ys) "*" = (x * y):ys
          f (x:y:ys) "+" = (x + y):ys
          f (x:y:ys) "-" = (y - x):ys
          f x num = (read num):x


main = do
    print (revList [1,2,3,4,5])
    print (dropList (-100) [1,2,3,4,5,6])
    print (fizzbuzz 10)
    print (fizzbuzz 3)
    print (fizzbuzz 75)
    print (fizzbuzz 101)
    print (quicksort [23,5,34,78,9,10,20])
    print (zipWith' (+) [1,2,3] [5,6,7])
    print ( 3 |> (*3) |> (+10) |> \x -> x * x)
    print (partition' (>3) [1,2,3,4,5,6])
    print $ area $ Rectangle 1 2 11 12
    print $ yesno MyTrue
    print $ yesno (0::Int)
    print $ rpn "90 34 12 33 55 66 + * - + -"


