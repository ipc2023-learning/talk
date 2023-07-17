PAPER = main
SHELL = /bin/bash

export BIBINPUTS=.:bib

## Main targets: paper, bib, clean, distclean
paper: $(PAPER).pdf

$(PAPER).pdf: FORCE
	pdflatex -shell-escape -file-line-error $(PAPER).tex
	#bibtex -min-crossrefs=99 $(PAPER)
	#pdflatex -shell-escape $(PAPER).tex
	pdflatex -shell-escape $(PAPER).tex

draft: FORCE
	pdflatex -shell-escape -file-line-error $(PAPER).tex

bib:
	bibtex -min-crossrefs=99 $(PAPER)

update-bib:
	rsync ~/Uni/papers/bib/*.bib bib/

push:
	git commit -am "Revise." && (git pull --rebase || true) && git push

clean:
	rm -f figures/*.aux figures/*.log
	rm -f $(PAPER).{aux,bbl,blg,fdb_latexmk,fls,log,lpg,nav,out,snm,synctex.gz,toc}

distclean: clean
	rm -f figures/*.pdf
	rm -f $(PAPER).pdf

FORCE:

.PHONY: paper bib clean distclean FORCE
