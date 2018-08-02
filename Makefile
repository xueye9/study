publish: clean
	git add -A
	git commit -m "Auto commit wiki files."
	vim -m +VimwikiIndex +VimwikiAll2HTML +qa
	git add -A
	git commit -m "Compile to html"
	git pull --rebase
	git push
 
clean:
	rm -rf html/*
