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
# Other

### VSCode扩展“Markdown Preview Enhanced”
尽管并不准备真的去写Markdown
但这个扩展在阅读一些内置代码的纯文本文件体验很好
比如同文件夹下的“ghc_options"

### 意味深远<del>大概</del>的恒等式
$$
    x^{2m} = (x^2)^m, x^{2m+1} = x(x^2)^m
$$
