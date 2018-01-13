import CommonWords(commonWords)
main = 
    do
    {
        putStrLn "Take test from where: ";
        infile <- getLine;
        putStrLn "How many words: ";
        n <- getLine;
        putStrLn "Put results where: ";
        outfile <- getLine;
        text <- readFile infile;
        writeFile outfile (commonWords (read n) text);
        putStrLn "cwords done!";
    }