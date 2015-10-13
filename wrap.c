#include <stdio.h>

#include "pocketsphinx.h"

#define MODELDIR "/home/ubuntu/sphinxfuzz/models"

#define TRUE 1
#define FALSE 0

void __afl_manual_init(void);

int
main(int argc, char *argv[])
{
	ps_decoder_t *ps;
	cmd_ln_t *config;
	FILE *fh;
	char const *hyp, *uttid;
        int16 buf[512];
	int rv;
	int32 score;

	config = cmd_ln_init(NULL, ps_args(), TRUE,
			     "-hmm", MODELDIR "/en-US",
			     "-dict", MODELDIR "/dict/en-US.dic",
			     NULL);
	if (config == NULL)
		return 1;
	ps = ps_init(config);
	if (ps == NULL)
		return 1;

	int result = ps_set_jsgf_string(ps, "name", "#JSGF V1.0; grammar test; public <simple> = hello ;"); 
	if (result != 0)
		return 1;

	ps_set_search(ps, "name");

        rv = ps_start_utt(ps);
	if (rv < 0)
	    return 1;

	// initialize fork server
	__afl_manual_init();

	fh = fopen(argv[1], "rb");
	if (fh == NULL)
	    return -1;

        while (!feof(fh)) {
            size_t nsamp;
            nsamp = fread(buf, 2, 512, fh);
            rv = ps_process_raw(ps, buf, nsamp, FALSE, FALSE);
        }
        rv = ps_end_utt(ps);
	if (rv < 0)
		return 1;
	hyp = ps_get_hyp(ps, &score);
	if (hyp == NULL)
		return 1;
	printf("Recognized: %s\n", hyp);

	fclose(fh);
        ps_free(ps);
        cmd_ln_free_r(config);
	return 0;
}
