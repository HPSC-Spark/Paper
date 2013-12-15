BASE=paper
TEMP_EXT=aux bbl blg log pdf
TEMP=$(addprefix $(BASE)., $(TEMP_EXT)) texput.log

$(BASE):
	pdflatex $(BASE).tex
	bibtex $(BASE)
	pdflatex $(BASE).tex
	pdflatex $(BASE).tex

clean:
	rm -f $(TEMP)
