/* 
	The generate_key function is available in this link
	http://www.codepool.biz/how-to-use-openssl-generate-rsa-keys-cc.html

	This uses openssl RSA key generation functions to produce public-private key pairs 
	and save them to .pem files

	Modified the code to record the latency of key generation. 
*/

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<openssl/des.h>
#include<openssl/rand.h>
#include <openssl/rsa.h>
#include <openssl/pem.h>
#include<sys/types.h>
#include<time.h>



FILE *fp;
char pubKey[20] ;
char priKey[20] ;

int generate_key(char pubKey[20], char priKey[20])
{
    int             ret = 0;
    RSA             *r = NULL;
    BIGNUM          *bne = NULL;
    BIO             *bp_public = NULL, *bp_private = NULL;
 
    int             bits = 2048;
    unsigned long   e = RSA_F4;
 
    bne = BN_new();
    ret = BN_set_word(bne,e);
    if(ret != 1){
        goto free_all;
    }
 
    r = RSA_new();
    ret = RSA_generate_key_ex(r, bits, bne, NULL);
    if(ret != 1){
        goto free_all;
    }
 
    bp_public = BIO_new_file(pubKey, "w+");
    ret = PEM_write_bio_RSAPublicKey(bp_public, r);
    if(ret != 1){
        goto free_all;
    }
 
    bp_private = BIO_new_file(priKey, "w+");
    ret = PEM_write_bio_RSAPrivateKey(bp_private, r, NULL, NULL, 0, NULL, NULL);
 
free_all:

    BIO_free_all(bp_public);
    BIO_free_all(bp_private);
    RSA_free(r);
    BN_free(bne);
 
    if (ret == 1)
	return 1;
    else 
	return 0;	
}

int main( int   argc,
          char *argv[] )
{
	fp = fopen("latency_file","w");
	FILE *fp1 = fopen("histogram","w");
	int key;
	char temp[5];
	double avg = 0;
	int copy;
	if(argc==2)
		copy = atoi(argv[1]);
	else 
		copy = 20;
	int tot = 2*copy;
	printf("\n\nGENERATING %d RSA PRIVATE-PUBLIC KEY PAIR: total %d key files\n",copy,tot);
	printf("LATENCY is recorded in the \"latency_file\" for each key-pair: total %d entries\n",copy);
	printf("LATENCIES FOR EACH RUN ARE...\n") ;
        for(key = 1; key <=copy; key++)
	{
		strcpy(pubKey,"public");
        	strcpy(priKey,"private");
        	snprintf (temp, sizeof(temp), "%d",key);
        	strcat(pubKey,temp);
        	strcat(pubKey,".pem");
        	strcat(priKey,temp);
        	strcat(priKey,".pem");
        	int rsa;
		clock_t begin = clock();
        	rsa = generate_key(pubKey, priKey);
		clock_t end = clock();
	        double time_spent = (double)(end - begin);
		time_spent = time_spent/CLOCKS_PER_SEC;
		avg = avg+time_spent;
        	printf("%f\n",time_spent);
		fprintf(fp,"%f,\n",time_spent);
	}
		avg = avg/copy;
		printf("\n AVERAGE LATENCY = %f\n",avg);
		fprintf(fp,"AVERAGE LATENCY of %d runs is = %f,\n",copy,avg);
	fclose(fp);
    return 0;
}

