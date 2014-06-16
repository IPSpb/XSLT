1) Список всех дисков, по умолчанию отсортированных по имени исполнителя
xsltproc catalog.xsl data.xml > catalog.html
2) Список дисков отортированных по имени альбома в обратном порядке
xsltproc -stringparam sortBy "title" -stringparam order "descending"  catalog.xsl data.xml > catalog.html
2) Список дисков отортированных по году
xsltproc -stringparam sortBy "year" catalog.xsl data.xml > catalog.html
3) Список дисков заданного исполнителя
xsltproc -stringparam artist "Radiohead" catalog.xsl data.xml > catalog.html
3) Список дисков заданного исполнителя за определенный год
xsltproc -stringparam artist "Radiohead" -stringparam year "1997"  catalog.xsl data.xml > catalog.html
