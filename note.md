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

### VSCode扩展“Markdown Preview Enhanced”
尽管并不准备真的去写Markdown
但这个扩展在阅读一些内置代码的纯文本文件体验很好
比如同文件夹下的“ghc_options"