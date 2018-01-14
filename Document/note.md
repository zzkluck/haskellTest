#Haskell

### 标准库函数
```haskell
    
```

### lambda表达式
以反斜杠开头，参数和函数体间用 `->` 连接
```haskell
    doubleThenSucc = \n -> 2*n + 1
```
### 引导库函数 Span
```haskell
    span :: (a -> Bool) -> [a] -> ([a], [a])
```
根据给定的谓词将集合划分为两部分
```haskell
    span :: (a -> Bool) -> [a] -> ([a], [a])
    span p [] = []
    span p (x:xs) =
        if p x then (x:ys,zs)
        else ([], x:xs)
        where (ys:zs) = span p xs
```
### 字符串转化相关show/read
注意，他们分别对应类族Show和Read

### 标准库函数fst和snd
<!--keyword: 二元组 tuple-->
```haskell
    fst :: (a, b) -> a
    fst (x, _) = x

    snd :: (a, b) -> b
    snd (_, y) = y
```
### 类族Num
```haskell
    class (Eq a, Show a) => Num a where
        (+),(-),(*) :: a -> a -> a
        negate      :: a -> a
        abs, sigum  :: a -> a           
        fromInteger :: Integer -> a
```
`abs`和`sigum`分别返回一个数的绝对值和符号，<b>如果允许在`Num`中有次序运算：</b>
```haskell
    abs x = if x > 0 then x else -x
    sigum x | x < 0 = -1
            | x == 0 = 0
            | x > 0 = 1
```
如你所见，基础的`Num`不能做除法。

`Num`有子类型`Real`和`Fractional`
```haskell
    class (Num a, Ord a) => Real a where
        toRational :: a -> Rational

    class (Num a) => Fractional a where
        (/) :: a -> a -> a
        fromRational :: Rational -> a
```
类型`Rational`本质上是整数对的同义词

`Real`有子类型`Integral`
```haskell
    class (Real a, Enum a) => Integral a where
        divMod :: a -> a -> (a, a)
        toInteger :: a -> Integer
    
    x `div` y = fst (x `divMod` y)
    x `mod` y = snd (x `divMod` y)
```
### 标准库函数until
```haskell
    until :: (a -> Bool) -> (a -> a) -> a -> a
    until p f x = if p x then x else until p f (f x)
```
本质上`until f p x`是计算下列无穷数列中第一个满足$p(y)=True$的元素：
$$[x, f(x), f(f(x)),f(f(f(x))),...]$$

### 标准库函数flip
```haskell
    flip f x y = f y x
```

### 标准库函数(`^`),(`^^`),(`**`)
<!--keyword: pow 幂 平方 开方 根号-->
```haskell
    (^) :: (Num a, Integral b) => a -> b -> a           --非负整数次幂
    (^^) :: (Fractional a, Integral b) => a -> b -> a   --任意整数次幂
    (**) :: (Floating a) => a -> a -> a                 --分数次幂
```

### 标准库函数reverse
```haskell
    reverse :: [a] -> [a]
```
反转一个列表

### 标准库函数filter
```haskell
    filter :: (a -> Bool) -> [a] -> [a]
```
filter返回列表中所有满足predicate的元素的列表

### 标准库函数null
```haskell
    Foldable t => t a -> Bool
```
返回一个列表是否为空

### 标准库函数iterate
```haskell
    iterate :: (a -> a) -> a -> [a]
    iterate f x = x : iterate f (f x)
```
这将返回一个无穷列表。另外，相信你一定想起了until：
```haskell
    until = head . filter p . iterate f
```
### 标准库函数head,last,tail,length
```haskell
    
```

### 列表List
```haskell
    data List a = Nil | Cons a (List a)
```
haskell语法支持枚举整数列表：
```haskell
    [m..n]
    [m..]
    [m,n..p]
    [m,n..]
```
事实上枚举并不局限于整数。所有Enum类族的类型都可以使用枚举。

haskell支持所谓的“列表概括”语法：
```haskell
    [x* x | x <- [1..5]]
    [x* x | x <- [1..5], isPrime x]
    divisors x = [d | d <- [2..x-1], x `mod` d == 0]
    disjoint xs ys = null [x|x<-xs, y<-ys, x==y]
    ...
```
列表概括可以用来定义列表上的某些常用函数：
```haskell
    map f xs    = [f x | x <- xs]
    filter p xs = [x | x <- xs, p x]
    concat xss  = [x | xs <- xss, x <-xs]
```
当然haskell中的实际情况是反过来，列表概括用这些函数定义.

### 标准库函数map, filter, concat
```haskell
    concat :: [[a]] -> [a]
    concat []           = []
    concat [xs:xss]     = xs ++ concat xss

    map :: (a -> b) -> [a] -> [b]
    map f []            = []
    map f [x:xs]        = f x:map f xs

    filter :: (a -> Bool) -> [a] -> [a]
    filter p []         = []
    filter p [x:xs]     = if p x then x:filter p xs
                            else filter p xs
    
    --filter还有另一种定义
    filter p xs = concat.map(test p) xs
                where test p x = if p x then [x] else []
```

### map与函子
map有两个基本性质：
```haskell
    map id      = id            --两边id类型不同
    map (f. g)  = map f. map g
```

# Other

### VSCode扩展“Markdown Preview Enhanced”
尽管并不准备真的去写Markdown
但这个扩展在阅读一些内置代码的纯文本文件体验很好
比如同文件夹下的“ghc_options"

### 意味深远<del>大概</del>的恒等式
$$
    x^{2m} = (x^2)^m, x^{2m+1} = x(x^2)^m
$$
