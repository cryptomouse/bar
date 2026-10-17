
INDIR=./src
OUTDIR=./out

# output dir prefix
MODESTPREFIX=$(OUTDIR)/modest
CPREFIX=$(OUTDIR)/c
LLVMPREFIX = $(OUTDIR)/llvm
C_OPTIONS = -std=c11 -Wall -Wextra -pedantic -Wno-unused-variable -Wno-unused-parameter


.PHONY: all, clean, Modest, LLVM, C


test: Modest LLVM C


Modest:
	modest -o $(MODESTPREFIX)/main -mbackend=modest $(INDIR)/main.modest
	modest -o $(MODESTPREFIX)/bar -mbackend=modest $(INDIR)/bar.modest


LLVM:
	modest -o $(LLVMPREFIX)/main -mbackend=llvm $(INDIR)/main.modest
	modest -o $(LLVMPREFIX)/bar -mbackend=llvm $(INDIR)/bar.modest
	clang -o bar $(LLVMPREFIX)/main.ll $(LLVMPREFIX)/bar.ll


C:
	modest -o $(CPREFIX)/main -mbackend=c11 $(INDIR)/main.modest
	modest -o $(CPREFIX)/bar -mbackend=c11 $(INDIR)/bar.modest
	clang -o bar $(C_OPTIONS) $(CPREFIX)/main.c $(CPREFIX)/bar.c


clean:
	rm *.o

