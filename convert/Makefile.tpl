# file: Makefile.tpl		G. Moody	24 May 2000
#				Last revised:	24 April 2020
# This section of the Makefile should not need to be changed.

CFILES = a2m.c ad2m.c ahaecg2mit.c m2a.c md2a.c readid.c makeid.c edf2mit.c \
 mit2edf.c parsescp.c rdedfann.c wav2mit.c mit2wav.c wfdb2mat.c revise.c
XFILES = \
 a2m$(EXEEXT) \
 ad2m$(EXEEXT) \
 ahaecg2mit$(EXEEXT) \
 m2a$(EXEEXT) \
 md2a$(EXEEXT) \
 readid$(EXEEXT) \
 makeid$(EXEEXT) \
 edf2mit$(EXEEXT) \
 mit2edf$(EXEEXT) \
 parsescp$(EXEEXT) \
 rdedfann$(EXEEXT) \
 wav2mit$(EXEEXT) \
 mit2wav$(EXEEXT) \
 wfdb2mat$(EXEEXT) \
 revise$(EXEEXT)
SCRIPTS = ahaconvert
MFILES = Makefile

# General rule for compiling C sources into executable files.  This is
# redundant for most versions of `make', but at least one System V version
# needs it.
.c:
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

# `make all': build applications
all:	$(XFILES)
	$(STRIP) $(XFILES)

# `make' or `make install':  build and install applications
install:	$(DESTDIR)$(BINDIR) all $(SCRIPTS)
	$(SETXPERMISSIONS) $(XFILES) $(SCRIPTS)
	../install.sh $(DESTDIR)$(BINDIR) $(XFILES) $(SCRIPTS)

# 'make collect': retrieve the installed applications
collect:
	../conf/collect.sh $(BINDIR) $(XFILES) $(SCRIPTS)

uninstall:
	../uninstall.sh $(DESTDIR)$(BINDIR) $(XFILES) $(SCRIPTS)

# `make clean':  remove intermediate and backup files
clean:
	rm -f $(XFILES) *.o *~

# `make listing': print a listing of WFDB format-conversion application sources
listing:
	$(PRINT) README $(MFILES) $(CFILES)

# Create directory for installation if necessary.
$(DESTDIR)$(BINDIR):
	mkdir -p $(DESTDIR)$(BINDIR)
	$(SETDPERMISSIONS) $(DESTDIR)$(BINDIR)
