#ifndef UUCPBB_SGSTAT_H
#define UUCPBB_SGSTAT_H
struct sgbuf {
	unsigned char sg_class;
	unsigned char sg_case;
	unsigned char sg_backsp;
	unsigned char sg_delete;
	unsigned char sg_echo;
	unsigned char sg_alf;
	unsigned char sg_nulls;
	unsigned char sg_pause;
	unsigned char sg_page;
	unsigned char sg_bspch;
	unsigned char sg_dlnch;
	unsigned char sg_eorch;
	unsigned char sg_eofch;
	unsigned char sg_rlnch;
	unsigned char sg_dulnch;
	unsigned char sg_psch;
	unsigned char sg_kbich;
	unsigned char sg_kbach;
	unsigned char sg_bsech;
	unsigned char sg_bellch;
	unsigned char sg_xon;
	unsigned char sg_xoff;
	unsigned char sg_tabcr;
	unsigned char sg_tabsiz;
	unsigned char sg_d2p;
	unsigned char sg_parity;
	unsigned char sg_baud;
	unsigned char sg_d2p1;
	unsigned char sg_xon1;
	unsigned char sg_xoff1;
	unsigned char sg_err;
	unsigned char sg_unused;
};

/**
 * @brief OS-9 RBF file descriptor sector layout.
 */
struct fildes {
	unsigned char fd_att;
	unsigned fd_own;
	unsigned char fd_date[5];
	unsigned char fd_link;
	long fd_fsize;
	unsigned char fd_dcr[3];
	struct {
		unsigned char addr[3];
		unsigned size;
	} fdseg[48];
};


#endif
