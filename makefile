defaultToDoNothing:
	echo "Use 'make [filename]' to do you want" 
	
cwords: cwords.hs CommonWords.hs
	ghc cwords.hs -o ./bin/cwords

clean:
	rm *.o *.hi