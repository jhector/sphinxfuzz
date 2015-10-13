SPHINXBASE= \
./sphinxbase/src/libsphinxbase/feat/lda.c \
./sphinxbase/src/libsphinxbase/feat/agc.c \
./sphinxbase/src/libsphinxbase/feat/feat.c \
./sphinxbase/src/libsphinxbase/feat/cmn_prior.c \
./sphinxbase/src/libsphinxbase/feat/cmn.c \
./sphinxbase/src/libsphinxbase/util/ckd_alloc.c \
./sphinxbase/src/libsphinxbase/util/matrix.c \
./sphinxbase/src/libsphinxbase/util/slamch.c \
./sphinxbase/src/libsphinxbase/util/err.c \
./sphinxbase/src/libsphinxbase/util/sbthread.c \
./sphinxbase/src/libsphinxbase/util/utf8.c \
./sphinxbase/src/libsphinxbase/util/errno.c \
./sphinxbase/src/libsphinxbase/util/bitvec.c \
./sphinxbase/src/libsphinxbase/util/hash_table.c \
./sphinxbase/src/libsphinxbase/util/dtoa.c \
./sphinxbase/src/libsphinxbase/util/bio.c \
./sphinxbase/src/libsphinxbase/util/mmio.c \
./sphinxbase/src/libsphinxbase/util/f2c_lite.c \
./sphinxbase/src/libsphinxbase/util/glist.c \
./sphinxbase/src/libsphinxbase/util/strfuncs.c \
./sphinxbase/src/libsphinxbase/util/case.c \
./sphinxbase/src/libsphinxbase/util/logmath.c \
./sphinxbase/src/libsphinxbase/util/heap.c \
./sphinxbase/src/libsphinxbase/util/profile.c \
./sphinxbase/src/libsphinxbase/util/pio.c \
./sphinxbase/src/libsphinxbase/util/huff_code.c \
./sphinxbase/src/libsphinxbase/util/filename.c \
./sphinxbase/src/libsphinxbase/util/slapack_lite.c \
./sphinxbase/src/libsphinxbase/util/blas_lite.c \
./sphinxbase/src/libsphinxbase/util/listelem_alloc.c \
./sphinxbase/src/libsphinxbase/util/cmd_ln.c \
./sphinxbase/src/libsphinxbase/util/genrand.c \
./sphinxbase/src/libsphinxbase/lm/jsgf_parser.c \
./sphinxbase/src/libsphinxbase/lm/jsgf_scanner.c \
./sphinxbase/src/libsphinxbase/lm/ngram_model_dmp.c \
./sphinxbase/src/libsphinxbase/lm/ngram_model_arpa.c \
./sphinxbase/src/libsphinxbase/lm/fsg_model.c \
./sphinxbase/src/libsphinxbase/lm/ngram_model_set.c \
./sphinxbase/src/libsphinxbase/lm/lm3g_model.c \
./sphinxbase/src/libsphinxbase/lm/ngram_model.c \
./sphinxbase/src/libsphinxbase/lm/jsgf.c \
./sphinxbase/src/libsphinxbase/fe/fixlog.c \
./sphinxbase/src/libsphinxbase/fe/fe_warp.c \
./sphinxbase/src/libsphinxbase/fe/fe_sigproc.c \
./sphinxbase/src/libsphinxbase/fe/yin.c \
./sphinxbase/src/libsphinxbase/fe/fe_warp_piecewise_linear.c \
./sphinxbase/src/libsphinxbase/fe/fe_noise.c \
./sphinxbase/src/libsphinxbase/fe/fe_prespch_buf.c \
./sphinxbase/src/libsphinxbase/fe/fe_warp_affine.c \
./sphinxbase/src/libsphinxbase/fe/fe_warp_inverse_linear.c \
./sphinxbase/src/libsphinxbase/fe/fe_interface.c

POCKETSPHINX= \
./pocketsphinx/src/ps_lattice.c \
./pocketsphinx/src/phone_loop_search.c \
./pocketsphinx/src/ngram_search_fwdflat.c \
./pocketsphinx/src/vector.c \
./pocketsphinx/src/tmat.c \
./pocketsphinx/src/fsg_lextree.c \
./pocketsphinx/src/pocketsphinx.c \
./pocketsphinx/src/allphone_search.c \
./pocketsphinx/src/kws_search.c \
./pocketsphinx/src/state_align_search.c \
./pocketsphinx/src/ps_alignment.c \
./pocketsphinx/src/ps_mllr.c \
./pocketsphinx/src/ms_senone.c \
./pocketsphinx/src/hmm.c \
./pocketsphinx/src/ptm_mgau.c \
./pocketsphinx/src/acmod.c \
./pocketsphinx/src/ms_gauden.c \
./pocketsphinx/src/bin_mdef.c \
./pocketsphinx/src/fsg_history.c \
./pocketsphinx/src/s2_semi_mgau.c \
./pocketsphinx/src/dict.c \
./pocketsphinx/src/ngram_search.c \
./pocketsphinx/src/blkarray_list.c \
./pocketsphinx/src/mdef.c \
./pocketsphinx/src/dict2pid.c \
./pocketsphinx/src/kws_detections.c \
./pocketsphinx/src/ms_mgau.c \
./pocketsphinx/src/fsg_search.c \
./pocketsphinx/src/ngram_search_fwdtree.c

WRAPPER=wrap.c

CC=/home/ubuntu/afl-1.94b/afl-clang-fast
INCLUDE_PATH=-I ./sphinxbase -I ./pocketsphinx
SOURCES=$(SPHINXBASE) $(POCKETSPHINX) $(WRAPPER)
CFLAGS=-lm -lpthread -DHAVE_UNISTD_H=1 -DHAVE_CONFIG_H=1
AFL_FLAGS=AFL_DEFER_FORKSRV=1 AFL_HARDEN=1

all:
	$(AFL_FLAGS) $(CC) $(INCLUDE_PATH) $(CFLAGS) $(SOURCES) -o wrapper
