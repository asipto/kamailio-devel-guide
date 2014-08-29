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

ifeq ($(DBHTMLXSL),)
DBHTMLXSL = /opt/local/share/xsl/docbook-xsl/html/docbook.xsl
# DBHTMLXSL = /usr/share/xml/docbook/stylesheet/nwalsh/html/docbook.xsl
endif

DBXML2HTMLPARAMS = --stringparam section.autolabel 1
DBXML2HTMLPARAMS += --stringparam section.label.includes.component.label 1
DBXML2HTMLPARAMS += --stringparam generate.toc "book toc,title,figure,table" 
DBXML2HTMLPARAMS += --stringparam html.stylesheet $(DBHTMLCSS)
endif

ifeq ($(DBXML2FO),)
DBXML2FO = $(shell which xsltproc)
endif

ifneq ($(DBXML2FO),)
ifeq ($(DBFOXSL),)
DBFOXSL = /opt/local/share/xsl/docbook-xsl/fo/docbook.xsl
# DBFOXSL = /usr/share/xml/docbook/stylesheet/nwalsh/fo/docbook.xsl
endif

DBXML2FOPARAMS = --stringparam use.extensions 0
DBXML2FOPARAMS += --stringparam fop1.extensions 1 
endif

ifeq ($(DBFO2PDF),)
DBFO2PDF = $(shell which fop)
endif

html:
	$(DBXML2HTML) -o $(OUTFNAME).html $(DBXML2HTMLPARAMS) $(DBHTMLXSL) \
							$(SRCFNAME).xml ;

pdf:
	$(DBXML2FO) -o $(OUTFNAME).fo $(DBXML2FOPARAMS) $(DBFOXSL) \
							$(SRCFNAME).xml ;
	$(DBFO2PDF) -fo $(OUTFNAME).fo -pdf $(OUTFNAME).pdf

clean:
	rm *.html
	rm *.fo
	rm *.pdf

