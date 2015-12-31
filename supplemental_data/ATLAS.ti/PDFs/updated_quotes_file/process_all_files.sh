#!/bin/sh

cp ../../../consolidated_bibtex_file.bib .

process_file(){
	filename=$1
	filename_without_tex_suffix=`echo $filename | cut -d '.' -f 1`

	pdflatex $filename
    bibtex $filename_without_tex_suffix
    if (grep "Warning" $filename_without_tex_suffix.blg > /dev/null ) then false ; fi
    while ( \
        pdflatex $filename_without_tex_suffix ; \
        grep "Rerun to get" $filename_without_tex_suffix.log > /dev/null \
    ) do true ; done
}

process_file standalone_quotes_file_with_references.tex



/bin/echo -n "clean up..."

rm -f *.log *.aux *.blg *.bbl

echo "done"

