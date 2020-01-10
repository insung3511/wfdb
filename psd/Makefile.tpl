# file: Makefile.tpl		G. Moody	  24 May 2000
#				Last revised:	 24 April 2020
# This section of the Makefile should not need to be changed.

# Programs to be compiled.
XFILES = \
 coherence$(EXEEXT) \
 fft$(EXEEXT) \
 log10$(EXEEXT) \
 lomb$(EXEEXT) \
 memse$(EXEEXT)

# Shell scripts to be installed.
SCRIPTS = hrfft hrlomb hrmem hrplot plot2d plot3d

# `make all': build applications
all:	$(XFILES)
	$(STRIP) $(XFILES)

# `make' or `make install':  build and install applications
install:	$(DESTDIR)$(BINDIR) all scripts
	$(SETXPERMISSIONS) $(XFILES)
	../install.sh $(DESTDIR)$(BINDIR) $(XFILES)

# 'make collect': retrieve the installed applications
collect:
	../conf/collect.sh $(BINDIR) $(XFILES) $(SCRIPTS)

# `make scripts': customize and install scripts
scripts:	$(DESTDIR)$(BINDIR)
	sed s+BINDIR+$(BINDIR)+g <hrfft >$(DESTDIR)$(BINDIR)/hrfft
	sed s+BINDIR+$(BINDIR)+g <hrlomb >$(DESTDIR)$(BINDIR)/hrlomb
	sed s+BINDIR+$(BINDIR)+g <hrmem >$(DESTDIR)$(BINDIR)/hrmem
	sed s+BINDIR+$(BINDIR)+g <hrplot >$(DESTDIR)$(BINDIR)/hrplot
	cp plot2d plot3d $(DESTDIR)$(BINDIR)
	cd $(DESTDIR)$(BINDIR); $(SETXPERMISSIONS) $(SCRIPTS)

uninstall:
	../uninstall.sh $(DESTDIR)$(BINDIR) $(XFILES) $(SCRIPTS)

coherence$(EXEEXT):	coherence.c
	$(CC) $(CFLAGS) -o coherence$(EXEEXT) -O coherence.c -lm

fft$(EXEEXT):		fft.c
	$(CC) $(CFLAGS) -o fft$(EXEEXT) -O fft.c -lm

log10$(EXEEXT):		log10.c
	$(CC) $(CFLAGS) -o log10$(EXEEXT) -O log10.c -lm

lomb$(EXEEXT):		lomb.c
	$(CC) $(CFLAGS) -o lomb$(EXEEXT) -O lomb.c -lm

memse$(EXEEXT):		memse.c
	$(CC) $(CFLAGS) -o memse$(EXEEXT) -O memse.c -lm

# `make clean': remove intermediate and backup files.
clean:
	rm -f *.o *~ $(XFILES)

# Create directory for installation if necessary.
$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)
	$(SETDPERMISSIONS) $(DESTDIR)$(BINDIR)
