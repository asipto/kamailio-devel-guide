#
#
SRCXML=devel-guide.xml
SRCFNAME=devel-guide
OUTFNAME=kamailio-devel-guide

ifeq ($(DBXML2HTML),)
DBXML2HTML = $(shell which xsltproc)
endif

ifneq ($(DBXML2HTML),)
ifeq ($(DBHTMLCSS),)
DBHTMLCSS = docbook.css
endif
DBHTMLXSL = /usr/share/xml/docbook/stylesheet/nwalsh/html/docbook.xsl
DBXML2HTMLPARAMS = --stringparam section.autolabel 1
DBXML2HTMLPARAMS += --stringparam section.label.includes.component.label 1
DBXML2HTMLPARAMS += --stringparam generate.toc "book toc,title,figure,table" 
DBXML2HTMLPARAMS += --stringparam html.stylesheet $(DBHTMLCSS)
endif

html:
	$(DBXML2HTML) -o $(OUTFNAME).html $(DBXML2HTMLPARAMS) $(DBHTMLXSL) \
							$(SRCFNAME).xml ;

clean:
	rm *.html
	rm *.pdf

